pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import qs
import "."
import QtQuick.Layouts

WlrLayershell {
    id: root

    // 1. Position: Top Right Corner, covering the full height
    // We make it a fixed width (e.g., 400px) so it doesn't block the whole screen
    anchors {
        top: true
        right: true
    }
    margins {
        top: 30
    }

    implicitWidth: 400
    implicitHeight: notifList.contentHeight + 10

    // 2. Layer: Put it ABOVE normal windows
    layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    // 3. CRITICAL: Make the window itself invisible!
    // We only want to see the notifications, not the container.
    color: "transparent"

    // 4. Input: Let clicks pass through empty areas
    // (This is default behavior if the background is transparent in some compositors,
    // but usually you need to be careful with handling mouse events here)

    // THE SPAWNER
    ListView {
        id: notifList
        anchors.fill: parent
        anchors.margins: 10
        // Use 'spacing' to put gaps between notifications
        spacing: 10

        // Align to the bottom (like Windows) or Top (like GNOME)?
        // verticalLayoutDirection: ListView.BottomToTop

        // 🔗 CONNECT TO THE SERVER
        // Assuming your NotificationServer is a singleton or globally accessible
        // ... other imports

        // Inside your ListView...
        model: NotifServer.trackedNotifications
        delegate: Item {
            id: notifyItem
            implicitWidth: ListView.view.width
            implicitHeight: 60 // Fixed height is usually better for icon layouts

            required property var modelData
            Timer {
                id: timout
                interval: 30000
                running: true
                onRunningChanged: notifyItem.modelData.dismiss()
            }

            Rectangle {
                anchors.fill: parent
                color: Colors.background
                radius: 10
                border.color: Colors.color5

                // 2. Use RowLayout to put Image | Text side-by-side
                Row {
                    anchors.margins: 10
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing: 15

                    // 🖼️ THE IMAGE ON THE LEFT
                    Image {

                        // Use the image if available, otherwise hide this space?
                        // Or you could use an icon fallback.
                        source: notifyItem.modelData.image
                        anchors.verticalCenter: parent.verticalCenter

                        // Hide if no image exists so text takes full width
                        visible: notifyItem.modelData.image !== ""

                        // Fixed size for consistency
                        width: 48
                        height: 48

                        // Crop it nicely so it doesn't stretch
                        fillMode: Image.PreserveAspectCrop

                        // Optional: Cache it for performance
                        asynchronous: true
                    }

                    // 📝 THE TEXT ON THE RIGHT
                    ColumnLayout {
                        // Take up all remaining width
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignTop // Center vertically
                        spacing: 2

                        Text {
                            text: notifyItem.modelData.summary
                            color: Colors.foreground
                            font.bold: true
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }

                        Text {
                            text: notifyItem.modelData.body
                            color: Colors.foreground

                            // Limit to 2 lines
                            maximumLineCount: 2
                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight

                            Layout.fillWidth: true
                        }
                    }
                }

                // (Your MouseArea for closing can still go here covering the whole thing)
                MouseArea {
                    anchors.fill: parent
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    acceptedButtons: Qt.LeftButton
                    onClicked: notifyItem.modelData.dismiss()
                }
            }
        }
    }
}

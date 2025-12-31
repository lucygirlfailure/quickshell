pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "."
import "../../"
import QtQuick.Layouts
import Quickshell.Widgets
import "../settings/"

WlrLayershell {
    id: root
    required property var modelData
    screen: {
        // Iterate through all connected Quickshell screens
        for (let i = 0; i < Quickshell.screens.length; i++) {
            let screenCandidate = Quickshell.screens[i];

            // Ask: "Is this screen the one Hyprland is currently focusing?"
            if (Hyprland.monitorFor(screenCandidate) === Hyprland.focusedMonitor) {
                return screenCandidate;
            }
        }
        return null; // Fallback (should rarely happen)
    }

    // 1. Position: Top Right Corner, covering the full height
    // We make it a fixed width (e.g., 400px) so it doesn't block the whole screen
    anchors {
        top: true
        right: true
    }
    margins {
        top: 36
        right: 00
    }

    implicitWidth: 300
    implicitHeight: notifList.contentHeight + 20
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuad
        }
    }

    // 2. Layer: Put it ABOVE normal windows
    layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    // 3. CRITICAL: Make the window itself invisible!
    // We only want to see the
    // notifications, not the container.
    color: "transparent"

    // 4. Input: Let clicks pass through empty areas
    // (This is default behavior if the background is transparent in some compositors,
    // but usually you need to be careful with handling mouse events here)

    // THE SPAWNER
    ListView {
        id: notifList
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 0
        // Use 'spacing' to put gaps between notifications
        spacing: 00
        height: contentHeight

        model: NotifServer.trackedNotifications
        delegate: Item {
            id: notifyItem
            required property var index
            readonly property bool isLast: index === (ListView.view.count - 1)
            implicitWidth: ListView.view.width
            implicitHeight: 85 // Fixed height is usually better for icon layouts
            height: implicitHeight

            required property var modelData
            Timer {
                id: timout
                interval: 3000
                running: true
                onTriggered: notifyItem.modelData.dismiss()
            }

            Rectangle {
                anchors.fill: parent
                color: Colors.background
                bottomLeftRadius: notifyItem.isLast ? 20 : 0
                border.color: Colors.color5
                border.width: 0

                // 2. Use RowLayout to put Image | Text side-by-side
                RowLayout {
                    id: fullLayout
                    anchors.margins: 10
                    anchors.fill: parent
                    spacing: 10

                    // 🖼️ THE IMAGE ON THE LEFT
                    ClippingWrapperRectangle {
                        radius: 10
                        implicitWidth: 64
                        implicitHeight: 64
                        visible: notifyItem.modelData.image !== ""
                        IconImage {

                            // Use the image if available, otherwise hide this space?
                            // Or you could use an icon fallback.
                            source: notifyItem.modelData.image

                            // Hide if no image exists so text takes full width
                            visible: notifyItem.modelData.image !== ""

                            // Fixed size for consistency
                            implicitSize: 30

                            // Crop it nicely so it doesn't stretch

                            // Optional: Cache it for performance
                            asynchronous: true
                        }
                    }

                    // 📝 THE TEXT ON THE RIGHT
                    ColumnLayout {
                        id: textLayout
                        // Take up all remaining width
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter  // Center vertically
                        spacing: 2

                        Text {
                            text: notifyItem.modelData.summary
                            color: Colors.foreground
                            font.family: Settings.font
                            font.pixelSize: Settings.fontSize
                            font.bold: true
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }

                        Text {
                            text: notifyItem.modelData.body
                            color: Colors.foreground

                            // Limit to 2 lines
                            font.family: Settings.font
                            font.pixelSize: Settings.fontSize - 2
                            maximumLineCount: 3
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

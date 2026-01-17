pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "."
import "../../"
import QtQuick.Layouts
import Quickshell.Widgets
import "../../settings/"

Variants {
    model: Quickshell.screens
    delegate: WlrLayershell {
        id: root
        required property var modelData
        screen: modelData

        anchors {
            top: true
            right: true
            bottom: true
        }
        margins {
            top: Settings.config.barHeight + 10
            right: 10
            left: 10
        }

        mask: Region { item: notifList }
        implicitHeight: notifList.contentHeight + 20
        implicitWidth: modelData.width / 8

        layer: WlrLayer.Overlay
        exclusionMode: ExclusionMode.Ignore

        color: "transparent"

        ListView {
            id: notifList
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 10
            height: contentHeight

            model: NotiServer.trackedNotifications
            delegate: Item {
                anchors.right: parent ? parent.right : root.right
                id: notifyItem
                required property var index
                implicitWidth: root.modelData.width / 8
                implicitHeight: notiIcon.implicitHeight + 20
                required property var modelData

                Rectangle {
                    anchors.fill: parent
                    color: Colors.background
                    border.color: Colors.color5
                    border.width: 2

                    RowLayout {
                        id: fullLayout
                        anchors.margins: 10
                        anchors.fill: parent
                        spacing: 10

                        ClippingWrapperRectangle {
                            id: notiIcon
                            radius: 0
                            implicitWidth: 64
                            implicitHeight: 64
                            visible: notifyItem.modelData.image !== ""
                            IconImage {
                                source: notifyItem.modelData.image
                                visible: notifyItem.modelData.image !== ""
                                implicitSize: 30
                                asynchronous: true
                            }
                        }

                        ColumnLayout {
                            id: textLayout
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignTop
                            spacing: 2

                            Text {
                                text: notifyItem.modelData.summary
                                color: Colors.foreground
                                font.family: Settings.config.font
                                font.pixelSize: Settings.config.fontSize
                                font.bold: true
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }

                            Text {
                                text: notifyItem.modelData.body
                                color: Colors.foreground

                                font.family: Settings.config.font
                                font.pixelSize: Settings.config.fontSize - 2
                                maximumLineCount: 3
                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                        }
                    }

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
}

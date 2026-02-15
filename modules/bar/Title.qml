import QtQuick
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell
import qs
import qs.settings
import qs.reusables
import QtQuick.Layouts

Rectangle {
    id: container
    radius: implicitHeight / 2
    color: Colors.surfaceContainer
    implicitWidth: root.implicitWidth
    implicitHeight: Settings.config.barHeight - 10
    Item {
        id: root
        anchors.centerIn: parent
        readonly property var activeWindow: ToplevelManager.activeToplevel
        implicitWidth: titleLayout.implicitWidth
        implicitHeight: titleText.implicitHeight
        RowLayout {
            id: titleLayout
            anchors.centerIn: parent

            anchors.fill: parent
            spacing: 5

            ClippingWrapperRectangle {
                radius: 30
                Layout.leftMargin: 10
                IconImage {
                    id: icon
                    source: root.activeWindow ? root.activeWindow.activated ? Quickshell.iconPath(root.activeWindow.appId, "") : "" : ""
                    implicitSize: root.activeWindow ? root.activeWindow.activated ? 16 : 0 : 0
                }
            }
            CustomText {
                id: titleText
                Layout.rightMargin: 10
                Layout.maximumWidth: 300
                text: root.activeWindow ? root.activeWindow.activated ? root.activeWindow.title : "Desktop" : "Desktop"
                onTextChanged: {}
                elide: Text.ElideRight
            }
        }
    }
}

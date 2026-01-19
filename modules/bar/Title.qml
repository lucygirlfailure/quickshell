import QtQuick
import Quickshell.Wayland
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: container
    radius: implicitHeight / 2
    color: Colors.color0
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: root.implicitWidth
    implicitHeight: Settings.config.barHeight - 10
    Item {
        id: root
        readonly property var activeWindow: ToplevelManager.activeToplevel
        implicitWidth: titleText.implicitWidth + 20
        implicitHeight: Settings.config.barHeight
        CustomText {
            id: titleText
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.activeWindow ? root.activeWindow.activated ? root.activeWindow.appId : "Desktop" : "Desktop"
            elide: Text.ElideRight
        }
    }
}

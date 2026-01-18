import QtQuick
import "../../reusables/"
import "../../settings/"
import "../../"
import Quickshell.Wayland

Rectangle {
    id: container
    radius: implicitHeight / 2
    color: Colors.color0
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth:  root.implicitWidth
    implicitHeight: Settings.config.barHeight - 10
    Item {
        id: root
        readonly property var activeWindow: ToplevelManager.activeToplevel
        implicitWidth:titleText.implicitWidth + 20
        implicitHeight: Settings.config.barHeight
        CustomText {
          anchors.horizontalCenter: parent.horizontalCenter
            id: titleText
            text: root.activeWindow.activated ? root.activeWindow.appId : "Desktop"
            elide: Text.ElideRight
        }
    }
}

import QtQuick
import "../../reusables/"
import "../../settings/"
import Quickshell.Hyprland

Item {
    id: root
    readonly property var activeWindow: Hyprland.activeToplevel
    implicitWidth: Math.min(text.implicitWidth, 500)
    implicitHeight: Settings.config.barHeight
    CustomText {
        anchors.left: parent.left
        anchors.right: parent.right
        id: text
        anchors.verticalCenter: parent.verticalCenter
        text: root.activeWindow ? Hyprland.activeToplevel.title : "Desktop"
        elide: Text.ElideRight
    }
}

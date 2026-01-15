import Quickshell
import QtQuick
import "../../reusables/"
import "../../settings/"
import "../../"
import Quickshell.Hyprland

Item {
    id: textContainer
    implicitWidth: text.implicitWidth
    implicitHeight: Settings.config.barHeight
    CustomText {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : "Desktop"
    }
}

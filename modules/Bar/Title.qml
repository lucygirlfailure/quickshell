import Quickshell
import QtQuick
import "../../reusables/"
import "../../settings/"
import "../../"
import Quickshell.Hyprland

Item {
    id: root
    implicitHeight: Settings.config.barHeight
    implicitWidth: textContainer.implicitWidth
    Rectangle {
        id: textContainer
        color: Colors.foreground
        implicitWidth: text.implicitWidth + 10
        implicitHeight: Settings.config.barHeight
        CustomText {
            id: text
            color: Colors.background
            anchors.centerIn: textContainer
            text: Hyprland.activeToplevel.activated ? Hyprland.activeToplevel.title : "sigma"
        }
    }
}

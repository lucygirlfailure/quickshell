import Quickshell
import QtQuick
import "../../reusables/"
import "../../settings/"
import "../../"
import Quickshell.Hyprland

Item {
    id: root
    readonly property var activeWindow: Hyprland.activeToplevel
    implicitWidth: text.implicitWidth
    implicitHeight: Settings.config.barHeight
    CustomText {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text: root.activeWindow?.activated ?Hyprland.activeToplevel.title : "Desktop"
    }
}

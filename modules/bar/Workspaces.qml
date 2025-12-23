import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitWidth: workspaceRow.implicitWidth
    height: 30
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 10 // Slightly increase spacing between workspace buttons

        Repeater {
            id: workspaceRepeater
            Rectangle {
                width: 14
                height: 14
                radius: 10
                //color: modelData.active ? myPallete.accent : myPallete.window
                color: modelData.active ? Colors.foreground : "transparent"

                Text {
                    id: workspaceNumber
                    font.weight: 900
                    font.family: Appearance.font
                    font.pixelSize: Appearance.fontSize
                    anchors.centerIn: parent
                    text: modelData.id
                    color: modelData.active ? Colors.background : Colors.foreground // Set contrasting color for workspace number
                }
            }
            model: Hyprland.workspaces
        }
    }
}

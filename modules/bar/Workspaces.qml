

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitWidth: workspaceRepeater.count * 30
    height: 30
    Row {
        anchors.centerIn: parent
        spacing: 10 // Slightly increase spacing between workspace buttons

        Repeater {
            id: workspaceRepeater
            model: Hyprland.workspaces

            Rectangle {
                width: 20
                height: 20
                radius: 20
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
        }
    }
}

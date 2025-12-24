import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs

Item {
    id: root
    property var modelData
    implicitWidth: workspaceRow.implicitWidth
    height: 30
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 10 // Slightly increase spacing between workspace buttons

        Repeater {
            anchors.centerIn: parent
            Rectangle {
                id: workspaceNumber
                width: 16
                height: 16
                radius: 20
                color: modelData.active ? Colors.foreground : "transparent"

                Text {
                    font.weight: 900
                    font.family: Appearance.font
                    font.pixelSize: Appearance.fontSize
                    anchors.centerIn: workspaceNumber
                    text: modelData.id
                    color: modelData.active ? Colors.background : Colors.foreground // Set contrasting color for workspace number
                }
            }
            model: Hyprland.workspaces
        }
    }
}

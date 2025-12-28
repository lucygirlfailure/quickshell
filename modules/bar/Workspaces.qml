pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import "../../"

Item {
    id: root
    implicitWidth: workspaceRow.implicitWidth
    height: 30
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 10 // Slightly increase spacing between workspace buttons

        Repeater {
            id: wsRepeater
            model: Hyprland.workspaces
            anchors.centerIn: parent
            Rectangle {
                id: workspaceNumber
                required property var modelData
                width: 16
                height: 16
                radius: 20
                color: modelData.active ? Colors.foreground : "transparent"

                Text {
                    font.weight: 900
                    font.family: Appearance.font
                    font.pixelSize: Appearance.fontSize
                    anchors.centerIn: workspaceNumber
                    text: parent.modelData.id
                    color: parent.modelData.active ? Colors.background : Colors.foreground // Set contrasting color for workspace number
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        parent.modelData.activate();
                    }
                }
            }
        }
    }
}

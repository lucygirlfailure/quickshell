pragma ComponentBehavior: Bound
import "../../reusables/"
import Quickshell.Hyprland
import Quickshell
import QtQuick
import "../../"
import "../../settings/"

Item {
    id: root
    implicitWidth: workspaceRow.implicitWidth
    height: 30
    required property var screen
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 0 // Slightly increase spacing between workspace buttons

        Repeater {
            id: wsRepeater
            model: Hyprland.workspaces
            anchors.centerIn: parent
            Rectangle {
                id: workspaceNumber
                property bool isOnMon: modelData.monitor == Hyprland.monitorFor(root.screen)
                required property var modelData
                width: isOnMon ? Settings.config.barHeight + 10 : 0
                height: isOnMon ? Settings.config.barHeight : 0
                color: modelData.active ? Colors.foreground : "transparent"

                CustomText {
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

pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import Quickshell
import QtQuick
import qs
import qs.settings
import qs.reusables

Item {
    id: root
    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight
    anchors.verticalCenter: parent.verticalCenter
    property var screen: screen
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 10 // Slightly increase spacing between workspace buttons

        Repeater {
            id: wsRepeater
            model: Hyprland.workspaces
            Rectangle {
                id: workspaceNumber
                anchors.verticalCenter: parent.verticalCenter
                radius: 20
                property bool isOnMon: {
                    if (!modelData)
                        return false;

                    if (!modelData.monitor)
                        return false;

                    if (!root.screen)
                        return false;
                    return modelData.monitor.name === root.screen.name;
                }

                required property var modelData
                width: isOnMon ? Settings.config.barHeight - Settings.config.barHeight / 2 : 0
                height: isOnMon ? Settings.config.barHeight - Settings.config.barHeight / 2 : 0
                color: "transparent"

                CustomText {
                    anchors.centerIn: workspaceNumber
                    text: parent.modelData.id
                    color: workspaceNumber.modelData.focused ? Colors.onSecondaryContainerColor : Colors.surfaceVariant
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

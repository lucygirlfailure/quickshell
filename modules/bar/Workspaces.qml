pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: root
    color: Colors.surfaceContainer

    implicitWidth: workspaceRow.implicitWidth + 10
    implicitHeight: Settings.config.barHeight - 10
    radius: Settings.config.barHeight / 2
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
                    color: Colors.onSurfaceColor
                    opacity: workspaceNumber.modelData.focused ? 1 : 0.5
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

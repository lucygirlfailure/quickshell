pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: root
    color: "transparent"

    implicitWidth: workspaceRow.implicitWidth + 10
    implicitHeight: Settings.config.barHeight - 10
    radius: Settings.config.barHeight / 2
    property var screen: screen
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 0 // Slightly increase spacing between workspace buttons

        Repeater {
            id: wsRepeater
            model: Hyprland.workspaces
            Rectangle {
                id: workspaceNumber
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
                width: Settings.config.barHeight - 5
                height: Settings.config.barHeight - 10
                color: modelData.focused ? Colors.primaryContainer : "transparent"
                Behavior on width {
                    NumberAnimation {

                        duration: 200
                        easing.type: Easing.Linear
                    }
                }

                CustomText {
                    anchors.centerIn: workspaceNumber
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: parent.modelData.id
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

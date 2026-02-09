pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: root
    color: Colors.surfaceContainer

    implicitWidth: workspaceRow.implicitWidth + 10
    implicitHeight: Settings.config.barHeight - 10
    radius: Settings.config.barHeight / 2
    property var screen: screen
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 5 // Slightly increase spacing between workspace buttons

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
                width: modelData.focused ? 40 : 20
                height: isOnMon ? Settings.config.barHeight - Settings.config.barHeight / 2 : 0
                color: modelData.focused ? Colors.primary : Colors.surfaceContainerHigh
                Behavior on width {
                    NumberAnimation {

                        duration: 200
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.34, 0.80, 0.34, 1.00, 1, 1]
                    }
                }

                CustomText {
                    anchors.centerIn: workspaceNumber
                    text: parent.modelData.id
                    color: modelData.focused ? Colors.onPrimaryColor : Colors.onSurfaceColor
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

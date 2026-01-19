pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs
import qs.settings

Variants {
    model: Quickshell.screens
    property var radius: root.container.radius

    delegate: PanelWindow {
        id: root
        required property var modelData
        implicitHeight: Settings.config.barHeight
        aboveWindows: true
        screen: modelData
        margins {
            top: Settings.config.margins
            left: Settings.config.margins
            right: Settings.config.margins
        }

        anchors {
            top: true
            left: true
            right: true
        }
        color: "transparent"
        Rectangle {
            id: container
            implicitHeight: Settings.config.barHeight
            anchors.fill: parent
            color: Colors.background
            radius: implicitHeight / 2

            Row {
                id: leftStuff
                leftPadding: 10
                spacing: 10
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Workspaces {
                    property var screen: root.modelData
                }
                Title {}
                Mpris {}
            }

            Row {
                id: centerStuff
                anchors.centerIn: parent
                Clock {}
            }

            Row {
                id: rightStuff
                rightPadding: 5
                spacing: 10
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                Volume {}
                Battery {}
                SysTray {}
            }
        }
    }
}

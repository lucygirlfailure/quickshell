pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs
import qs.settings

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
        id: root
        required property var modelData
        implicitHeight: Settings.config.barHeight
        aboveWindows: true
        screen: modelData
        margins {
            top: Settings.config.floating ? Settings.config.margins : 0
            left: Settings.config.floating ? Settings.config.margins : 0
            right: Settings.config.floating ? Settings.config.margins : 0
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
            color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, Settings.config.translucency)
            radius: Settings.config.floating ? Settings.config.barHeight / 2 : 0

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
                SettingsIcon {}
            }
        }
    }
}

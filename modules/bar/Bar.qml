import Quickshell
import QtQuick
import "../../settings/"
import "../../"

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
        id: root
        implicitHeight: Settings.config.barHeight
        aboveWindows: true
        required property var modelData
        color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.6)
        screen: modelData
        anchors {
            top: true
            left: true
            right: true
        }
        Row {
            id: leftStuff
            leftPadding: 10
            spacing: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Workspaces {
                property var screen: root.modelData
            }
            Title {}
        }

        Row {
            id: centerStuff
            anchors.centerIn: parent
            Clock {}
        }

        Row {
            id: rightStuff
            rightPadding: 10
            spacing: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Volume {}
            Battery {}
            SystemTray {}
        }
    }
}

import Quickshell
import QtQuick
import "../../settings/"
import "../../"
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
        id: root
        required property var modelData
        screen: modelData
        color: Colors.background
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: Settings.config.barHeight
        Row {
            leftPadding: 10
            id: leftStuff
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
            rightPadding: 10
            id: rightStuff
            spacing: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Volume {}
            Battery {}
            SystemTray {}
        }
    }
}

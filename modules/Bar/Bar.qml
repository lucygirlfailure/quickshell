import Quickshell
import QtQuick
import "../../settings/"
import "../../"
import "../../reusables/"
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
            id: leftStuff
            spacing: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Workspaces {
                property var screen: modelData
            }
            Title {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: centerStuff
            anchors.centerIn: parent
        }

        Row {
            id: rightStuff
            spacing: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Clock {}
            Volume {}
            SystemTray {}
            Battery {}
        }
    }
}

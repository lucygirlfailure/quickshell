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
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Workspaces {
                property var screen: modelData
            }
        }

        Row {
            id: centerStuff
            anchors.centerIn: parent
            Title {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: rightStuff
            spacing: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Clock {}
            Volume {}
            Battery {}
        }
    }
}

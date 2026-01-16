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
        RowLayout {
            id: leftStuff
            spacing: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Workspaces {
                property var screen: root.modelData
                Layout.leftMargin: 10
            }
            Title {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: centerStuff
            anchors.centerIn: parent
            Clock {}
        }

        RowLayout {
            id: rightStuff
            spacing: 20
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Volume {}
            Battery {}
            SystemTray {
              Layout.rightMargin: 10
            }
        }
    }
}

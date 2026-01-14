import Quickshell
import QtQuick
import "../../settings/"
import "../../"
import "../../reusables/"
import QtQuick.Layouts

PanelWindow {
    id: root
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
        CustomText {
            text: "workspaces here"
        }
    }

    Row {
        id: centerStuff
        anchors.centerIn: parent
        CustomText {
            text: "windowtitle here"
        }
    }

    Row {
        id: rightStuff
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        CustomText {
            text: "status shit goes here"
        }
    }
}

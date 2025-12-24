import Quickshell
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    id: root
    implicitHeight: 30
    color: Colors.background
    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        id: leftLayout
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Workspaces {
            Layout.leftMargin: 10
        }
    }

    RowLayout {
        id: centerLayout
        anchors.centerIn: parent
        Clock {}
    }

    RowLayout {
        id: rightLayout
        spacing: 10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Volume {}
        Battery {}
        SystemTray {
            Layout.rightMargin: 10
        }
    }
}

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs

PanelWindow {
    id: root
    required property var modelData
    implicitHeight: 30
    //color: Colors.background
    color: "black"
    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        id: leftLayout
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Clock {
            Layout.leftMargin: 30
        }
    }

    RowLayout {
        id: centerLayout
        anchors.centerIn: parent
        Workspaces {}
    }

    RowLayout {
        id: rightLayout
        spacing: 20
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Volume {}
        Battery {}
        SystemTray {
            Layout.rightMargin: 30
        }
    }
}

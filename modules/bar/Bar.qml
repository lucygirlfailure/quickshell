import Quickshell
import QtQuick
import qs.modules.bar
import QtQuick.Layouts

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
        Workspaces {}
    }

    RowLayout {
        id: centerLayout
        anchors.centerIn: parent
    }

    RowLayout {
        id: rightLayout
        spacing: 0
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Volume {}
        Battery {}
        SystemTray {
            Layout.rightMargin: 10
        }
    }
}

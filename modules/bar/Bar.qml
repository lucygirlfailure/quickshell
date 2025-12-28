import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../"

PanelWindow {
    id: root
    required property var modelData
    implicitHeight: 34
    color: Colors.background
    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        id: leftLayout
        spacing: 30
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Clock {
            Layout.leftMargin: 30
        }
        Mpris {}
    }

    RowLayout {
        id: centerLayout
        anchors.centerIn: parent
        Workspaces {}
    }

    RowLayout {
        id: rightLayout
        spacing: 30
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Volume {}
        PowerProfiles {}
        SystemTray {
            Layout.rightMargin: 30
        }
    }
}

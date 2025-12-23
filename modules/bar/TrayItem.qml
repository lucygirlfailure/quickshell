import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

MouseArea {
    id: root
    property var bar: root.QsWindow.window
    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 16
    implicitHeight: 16

    onClicked: event => {
        if (event.button === Qt.LeftButton) {
            modelData.activate();
        } else if (modelData.hasMenu) {
            menu.open();
        }
    }

    QsMenuAnchor {
        id: menu
        menu: root.modelData.menu
        anchor.item: root
    }

    IconImage {
        id: trayIcon
        width: parent.implicitWidth
        height: parent.implicitHeight
        source: root.modelData.icon
        anchors.centerIn: parent
    }
}

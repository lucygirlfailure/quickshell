import Quickshell.Services.SystemTray
import QtQuick

Item {
    id: root
    clip: true

    implicitWidth: layout.implicitWidth < 0 ? 0 : layout.implicitWidth
    implicitHeight: 34

    visible: layout.children.length > 0

    Row {
        id: layout
        anchors.centerIn: parent
        spacing: 10 // Spacing between icons

        Repeater {
            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}

import Quickshell.Services.SystemTray
import QtQuick

Item {
    id: root
    clip: true

    // This was already correct in your last file, but keep it this way!
    implicitWidth: layout.implicitWidth
    implicitHeight: 30

    // Hide if empty so we don't have a 50px gap for nothing
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

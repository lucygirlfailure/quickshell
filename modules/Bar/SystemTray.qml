import Quickshell.Services.SystemTray
import QtQuick
import "."
import "../../settings/"

Item {
    id: root
    implicitWidth: trayRow.implicitWidth
    implicitHeight: Settings.config.barHeight
    Row {
        id: trayRow
        Repeater {
            id: trayRepeater
            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}

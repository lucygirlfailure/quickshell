import Quickshell.Services.SystemTray
import QtQuick
import "."
import "../../settings/"

Item {
    id: root
    implicitWidth: trayRow.implicitWidth
    implicitHeight: Settings.config.barHeight
    visible: trayRepeater.count > 0

    Row {
        id: trayRow
        anchors.verticalCenter: parent.verticalCenter
        Repeater {
            id: trayRepeater
            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}

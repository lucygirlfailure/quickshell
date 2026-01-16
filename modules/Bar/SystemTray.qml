import Quickshell.Services.SystemTray
import QtQuick
import "."
import "../../settings/"

Item {
    id: root
    implicitWidth: trayRow.implicitWidth
    implicitHeight: Settings.config.barHeight
    anchors.verticalCenter: parent.verticalCenter

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

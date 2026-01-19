import Quickshell.Services.SystemTray
import QtQuick
import "."
import "../../settings/"

Item {
    id: root
    implicitWidth: trayRow.implicitWidth + 5
    implicitHeight: Settings.config.barHeight
    readonly property var count: trayRepeater.count
    visible: trayRepeater.count > 0

    Row {
        id: trayRow
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter
        Repeater {
            id: trayRepeater
            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}

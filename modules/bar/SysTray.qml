import Quickshell.Services.SystemTray
import QtQuick
import qs.settings
import qs

Rectangle {
    id: root
    implicitWidth: trayRow.implicitWidth + 10
    implicitHeight: Settings.config.barHeight - 10
    radius: implicitHeight / 2
    color: Colors.surfaceContainer
    readonly property var count: trayRepeater.count
    visible: trayRepeater.count > 0

    Row {
        id: trayRow
        spacing: 5
        anchors.centerIn: parent
        Repeater {
            id: trayRepeater
            model: SystemTray.items
            delegate: TrayItem {}
        }
    }
}

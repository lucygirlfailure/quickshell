pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: settings
    property alias config: settingsAdapter
    onConfigChanged: {
        settingsView.writeAdapter();
    }
    FileView {
        id: settingsView

        path: "/home/lucy/.config/quickshell/settings/config.json"
        watchChanges: true
        Component.onCompleted: {
            settingsView.writeAdapter();
        }

        adapter: JsonAdapter {
            id: settingsAdapter
            property var barHeight: 28
            property var font: "JetBrainsMono Nerd Font"
            property var fontSize: 14
            property var rounding: 10
            property var wallDir: "/home/lucy/.walls"
        }
    }
}

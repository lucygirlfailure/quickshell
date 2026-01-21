pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias config: settingsAdapter
    property alias currentWall: settingsAdapter.currentWall
    onConfigChanged: {
        console.log('config change detected, writing adapter');
        settingsView.writeAdapter();
    }

    FileView {
        id: settingsView

        onAdapterUpdated: writeAdapter()
        path: "/home/lucy/.config/quickshell/settings/config.json"
        watchChanges: false

        adapter: JsonAdapter {
            id: settingsAdapter
            property var margins: 10
            property var currentWall: ""
            property var barHeight: 28
            property var font: "Google Sans"
            property var fontSize: 14
            property var rounding: 10
            property var wallDir: "file:///home/lucy/.walls/"
            property bool floating: true
            property int paddingTop: 10
            property int paddingSides: 10
            property var generateScheme: true
        }
    }
}

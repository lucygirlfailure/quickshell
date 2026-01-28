pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias config: settingsAdapter
    onConfigChanged: settingsView.writeAdapter()
    FileView {
        id: settingsView

        path: "/home/lucy/.config/qs.json"
        watchChanges: true
        onAdapterUpdated: writeAdapter()
        onFileChanged: reload()
        adapter: JsonAdapter {
            id: settingsAdapter
            property var margins: 20
            property var currentWall: ""
            property var barHeight: 30
            property var font: ""
            property var fontSize: 14
            property var wallDir: "file:///home/lucy/.walls/"
            property bool floating: false
            property var generateScheme: true
            property bool wallSwitcherShown: false
            property int fontWeight: 600
            property bool showScreenCorners: true
            property int screenCornerRadius: 10
            property double translucency: 1
            property bool blackScreenCorners: true
            property bool settingsShown: true
        }
    }
}

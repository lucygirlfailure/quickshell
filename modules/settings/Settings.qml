pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property alias currentWall: jsonAdapter.currentWall
    property alias font: jsonAdapter.font
    property alias fontSize: jsonAdapter.fontSize
    property alias wallDir: jsonAdapter.wallDir
    onCurrentWallChanged: settingsView.writeAdapter()
    onWallDirChanged: settingsView.writeAdapter()
    onFontChanged: {
        Quickshell.reload();
        settingsView.writeAdapter();
    }
    onFontSizeChanged: settingsView.writeAdapter()

    FileView {
        id: settingsView
        path: "/home/lucy/.config/quickshell/modules/settings/config.json"

        watchChanges: true
        onAdapterChanged: reload()
        onAdapterUpdated: reload()

        adapter: JsonAdapter {
            id: jsonAdapter
            property string currentWall: ""
            property string wallDir: "/home/lucy/.walls/"
            property string font: "Google Sans"
            property real fontSize: 14
        }
    }
}

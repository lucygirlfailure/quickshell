pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell

FileView {
    id: settingsView
    path: "/home/lucy/.cache/quickshell_settings.json"

    watchChanges: true
    onAdapterUpdated: writeAdapter()

    adapter: JsonAdapter {
        id: jsonAdapter
        property string currentWall: ""
        property string wallDir: "/home/lucy/.walls/"
        property string font: "CommitMono Nerd Font Propo"
        property real fontSize: 12
    }
    onCurrentWallChanged: writeAdapter()
    onWallDirChanged: writeAdapter()
    onFontChanged: writeAdapter()
    onFontSizeChanged: writeAdapter()

    property alias currentWall: jsonAdapter.currentWall
    property alias font: jsonAdapter.font
    property alias fontSize: jsonAdapter.fontSize
    property alias wallDir: jsonAdapter.wallDir
}

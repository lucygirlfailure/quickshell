pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

FileView {
    id: settingsView
    path: "/home/lucy/.cache/quickshell_settings.json"

    watchChanges: true
    onAdapterChanged: writeAdapter()

    adapter: JsonAdapter {
        id: jsonAdapter
        property string currentWall: ""
        property string wallDir: "/home/lucy/.walls/"
        property string font: "SFMono Nerd Font Propo"
        property real fontSize: 14

        onCurrentWallChanged: settingsView.writeAdapter()
        onWallDirChanged: settingsView.writeAdapter()
        onFontChanged: settingsView.writeAdapter()
        onFontSizeChanged: settingsView.writeAdapter()
    }
    property alias currentWall: jsonAdapter.currentWall
    property alias font: jsonAdapter.font
    property alias fontSize: jsonAdapter.fontSize
    property alias wallDir: jsonAdapter.wallDir
}

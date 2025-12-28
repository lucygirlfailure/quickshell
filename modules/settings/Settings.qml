pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: store

    FileView {
        path: "/home/lucy/.cache/quickshell_settings.json"

        onAdapterUpdated: writeAdapter()

        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter
            property string lastWallpaper: "file:///home/lucy/.walls/mooon.png"
            property string wallDir: "file:///home/lucy/.walls/"
            property string font: "CodeNewRoman  Nerd Font Propo"
            property real fontSize: 14
        }
    }

    property alias currentWall: adapter.lastWallpaper
    property alias font: adapter.font
    property alias fontSize: adapter.fontSize
    property alias wallDir: adapter.wallDir
}

pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    FileView {
        path: "/home/lucy/.cache/quickshell_settings.json"

        watchChanges: true
        onAdapterChanged: writeAdapter()

        JsonAdapter {
            id: adapter
            property string lastWallpaper
            property string wallDir
            property string font
            property real fontSize: 12
        }
    }

    property alias currentWall: adapter.lastWallpaper
    property alias font: adapter.font
    property alias fontSize: adapter.fontSize
    property alias wallDir: adapter.wallDir
}

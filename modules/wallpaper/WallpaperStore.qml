pragma Singleton
import QtQuick
import Quickshell.Io // <--- Import for FileView and JsonAdapter

QtObject {
    id: store

    // 1. The File Manager
    property string wallDir: "~/.walls/"
    property var settings: FileView {
        path: "/home/lucy/.cache/quickshell_settings.json"

        // Auto-save when properties change
        onAdapterUpdated: writeAdapter()

        // Auto-load when the file changes on disk
        watchChanges: true
        onFileChanged: reload()

        // 2. The Magic Adapter
        JsonAdapter {
            id: adapter
            // This property corresponds to a key in your JSON file!
            property string lastWallpaper: "/home/lucy/.walls/frieren_river.jpg"
        }
    }

    // 3. Create a helper property for the rest of your app to use
    // This keeps the "WallpaperStore.currentWall" name working!
    property alias currentWall: adapter.lastWallpaper
}

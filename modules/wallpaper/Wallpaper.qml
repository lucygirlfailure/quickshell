import QtQuick
import Quickshell
import Quickshell.Wayland
import "."
import Quickshell.Io

WlrLayershell {
    id: root

    // 1. Send it to the bottom of the stack!
    layer: WlrLayer.Background

    // 2. Stretch it to cover the ENTIRE screen
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // 3. IMPORTANT: Tell the compositor NOT to reserve space for this.
    // If you don't do this, your wallpaper might push your windows aside!
    exclusionMode: ExclusionMode.Ignore

    // 4. The actual content

    Image {
        id: actualWall
        anchors.fill: parent
        source: WallpaperStore.currentWall
    }
}

import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../"
import "."

WlrLayershell {
    id: overlayRoot
    required property var modelData

    // 1. Fill the entire screen
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // 2. Sit on top of EVERYTHING (even fullscreen apps if compositor allows)
    layer: WlrLayer.Top

    // 3. Invisible background
    color: "transparent"

    // 4. 👻 GHOST MODE ENABLED 👻
    // An empty Region means "I accept mouse events nowhere".
    // This guarantees you can click through the black corners.
    mask: Region {}

    // 5. Load the corners!
    ScreenCorners {
        // Adjust these to match your screen's aesthetic
        cornerRadius: 25
        cornerColor: Colors.background
        shouldShow: true

        // Ensure it stays on top of any other items in this window
        z: 999
    }
}

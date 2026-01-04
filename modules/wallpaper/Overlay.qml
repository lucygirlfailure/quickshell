import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../../"
import "."

WlrLayershell {
    id: overlayRoot
    required property var modelData
    property var padding: 5
    property var rounding: 20
    onPaddingChanged: {
        hyprGaps.exec(hyprGaps.command);
        console.log(hyprGaps.command);
    }

    Process {
        id: hyprGaps
        running: true
        property bool isZero: overlayRoot.padding === 0
        property var top: isZero ? 10 : overlayRoot.padding * 2
        property var sides: overlayRoot.padding + top
        property var gaps: top + "," + sides + "," + sides + "," + sides
        command: ["hyprctl", "keyword", "general:gaps_out", gaps]
        onStarted: console.log("set gaps to ", gaps)
    }
    Process {
        id: hyprRounding
        property var rounding: overlayRoot.rounding - 5
        running: true
        command: ["hyprctl", "keyword", "decoration:rounding", rounding]
        onStarted: console.log("set rounding to ", overlayRoot.rounding)
    }
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
    ScreenPadding {
        paddingWidth: overlayRoot.padding
        paddingColor: Colors.background
    }
    ScreenCorners {
        // Adjust these to match your screen's aesthetic
        cornerRadius: overlayRoot.rounding
        margin: overlayRoot.padding
        cornerColor: Colors.background
    }
}

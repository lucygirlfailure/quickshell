pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls // <--- Needed for StackView
import Quickshell
import Quickshell.Wayland

WlrLayershell {
    id: root
    layer: WlrLayer.Background
    keyboardFocus: WlrKeyboardFocus.None
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // We need to accept the screen from Variants
    required property var modelData

    // 1. The StackView manages the images
    StackView {
        id: wallStack
        width: parent.width
        height: parent.height

        // 2. Define what a "Wallpaper" looks like
        Component {
            id: wallComponent
            Image {
                fillMode: Image.PreserveAspectCrop
                width: wallStack.width
                height: wallStack.height
                asynchronous: true // ⚡ VERY IMPORTANT: Prevents lag while loading!
            }
        }

        // 4. THE ANIMATIONS 🎬
        // When a new wall replaces the old one:

        // New One: Fades In (0 -> 1)
        replaceEnter: Transition {
            NumberAnimation {
                property: "x"
                from: wallStack.width
                to: 0
                duration: 800 // Slower = Smoother
                easing.type: Easing.OutQuad
            }
        }

        // Old One: Fades Out (1 -> 0)
        replaceExit: Transition {
            NumberAnimation {
                property: "x"
                from: 0
                to: -wallStack.width
                duration: 800
                easing.type: Easing.OutQuad
            }
        }
    }

    // 5. The Trigger 🔫
    // We listen for the singleton to change, then tell the Stack to update
    Connections {
        target: WallpaperStore

        function onCurrentWallChanged() {
            // "Replace the current item with a new wallComponent using the new source"
            wallStack.replace(wallComponent, {
                "source": WallpaperStore.currentWall
            });
        }
    }
}

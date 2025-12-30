import QtQuick
import QtQuick.Shapes
import Quickshell

Item {
    id: root

    // Make sure this fills the screen!
    anchors.fill: parent

    property real paddingWidth // Example default
    property color paddingColor

    Shape {
        anchors.fill: parent

        // 1. LEFT PADDING (Your existing one, cleaned up)
        ShapePath {
            strokeWidth: root.paddingWidth * 2
            strokeColor: root.paddingColor
            fillColor: "transparent" // We only want the stroke

            // Start at Top-Left (x=0, y=0)
            // We use '0' to align center with edge, so half is in, half is out
            startX: 0
            startY: 0

            PathLine {
                x: root.paddingWidth - root.paddingWidth
                y: root.height + root.paddingWidth// Go to Bottom-Left
            }
        }

        // 2. RIGHT PADDING
        ShapePath {
            strokeWidth: root.paddingWidth * 2
            strokeColor: root.paddingColor
            fillColor: "transparent"

            // Start at Top-Right
            startX: root.width
            startY: 0

            PathLine {
                x: root.width
                y: root.height // Go to Bottom-Right
            }
        }

        // 3. BOTTOM PADDING (The one you wanted!)
        ShapePath {
            strokeWidth: root.paddingWidth * 2
            strokeColor: root.paddingColor
            fillColor: "transparent"

            // Start at Bottom-Left
            startX: 0
            startY: root.height

            PathLine {
                // Draw to Bottom-Right
                x: root.width
                y: root.height
            }
        }
    }
}

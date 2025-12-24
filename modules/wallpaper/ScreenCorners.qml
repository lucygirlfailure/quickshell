import QtQuick
import QtQuick.Shapes
import qs

// removed "import qs.Commons" because you don't have it!

Item {
    id: root
    anchors.fill: parent

    // ---------------------------------------------------------
    // 🛠️ CONFIGURATION (Tweaked to match your setup)
    // ---------------------------------------------------------

    // How round do you want the screen?
    property real cornerRadius: 20

    // What color should the corners be? (Usually black to match the bezel)
    // You can change this to "transparent" or a theme color if you want.
    property color cornerColor: Colors.background

    // Enable/Disable toggle
    property bool shouldShow: true

    // ---------------------------------------------------------

    // Wrapper with layer caching to reduce GPU usage
    Item {
        anchors.fill: parent
        layer.enabled: true

        Shape {
            id: cornersShape
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            enabled: false // Click-through

            ShapePath {
                id: cornersPath

                // Map our local properties to the variables the code expects
                readonly property real cornerRadius: root.cornerRadius
                readonly property real cornerSize: root.cornerRadius // Usually same as radius

                // Margins (Leave 0 unless your bar overlaps)
                readonly property real topMargin: 0
                readonly property real bottomMargin: 0
                readonly property real leftMargin: 0
                readonly property real rightMargin: 0

                readonly property real screenWidth: cornersShape.width
                readonly property real screenHeight: cornersShape.height

                strokeWidth: -1 // No outline
                fillColor: Colors.background

                // Smooth fade if you toggle it

                // ==========================================
                // 📐 GEOMETRY LOGIC (Untouched)
                // ==========================================

                // Top-Left
                startX: leftMargin
                startY: topMargin
                PathLine {
                    relativeX: cornersPath.cornerSize
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: cornersPath.cornerSize - cornersPath.cornerRadius
                }
                PathArc {
                    relativeX: -cornersPath.cornerRadius
                    relativeY: cornersPath.cornerRadius
                    radiusX: cornersPath.cornerRadius
                    radiusY: cornersPath.cornerRadius
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    relativeX: -(cornersPath.cornerSize - cornersPath.cornerRadius)
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: -cornersPath.cornerSize
                }

                // Top-Right
                PathMove {
                    x: cornersPath.screenWidth - cornersPath.rightMargin - cornersPath.cornerSize
                    y: cornersPath.topMargin
                }
                PathLine {
                    relativeX: cornersPath.cornerSize
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: cornersPath.cornerSize
                }
                PathLine {
                    relativeX: -(cornersPath.cornerSize - cornersPath.cornerRadius)
                    relativeY: 0
                }
                PathArc {
                    relativeX: -cornersPath.cornerRadius
                    relativeY: -cornersPath.cornerRadius
                    radiusX: cornersPath.cornerRadius
                    radiusY: cornersPath.cornerRadius
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    relativeX: 0
                    relativeY: -(cornersPath.cornerSize - cornersPath.cornerRadius)
                }
                // Bottom-Left
                PathMove {
                    x: cornersPath.leftMargin
                    y: cornersPath.screenHeight - cornersPath.bottomMargin - cornersPath.cornerSize
                }
                PathLine {
                    relativeX: cornersPath.cornerSize - cornersPath.cornerRadius
                    relativeY: 0
                }
                PathArc {
                    relativeX: cornersPath.cornerRadius
                    relativeY: cornersPath.cornerRadius
                    radiusX: cornersPath.cornerRadius
                    radiusY: cornersPath.cornerRadius
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    relativeX: 0
                    relativeY: cornersPath.cornerSize - cornersPath.cornerRadius
                }
                PathLine {
                    relativeX: -cornersPath.cornerSize
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: -cornersPath.cornerSize
                }

                // Bottom-Right
                PathMove {
                    x: cornersPath.screenWidth - cornersPath.rightMargin
                    y: cornersPath.screenHeight - cornersPath.bottomMargin
                }
                PathLine {
                    relativeX: -cornersPath.cornerSize
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: -(cornersPath.cornerSize - cornersPath.cornerRadius)
                }
                PathArc {
                    relativeX: cornersPath.cornerRadius
                    relativeY: -cornersPath.cornerRadius
                    radiusX: cornersPath.cornerRadius
                    radiusY: cornersPath.cornerRadius
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    relativeX: cornersPath.cornerSize - cornersPath.cornerRadius
                    relativeY: 0
                }
                PathLine {
                    relativeX: 0
                    relativeY: cornersPath.cornerSize
                }
            }
        }
    }
}

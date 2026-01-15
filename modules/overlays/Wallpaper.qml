import Quickshell
import QtQuick
import Quickshell.Wayland
import "../../settings/"

Variants {
    id: root
    model: Quickshell.screens
    delegate: WlrLayershell {
      required property var modelData
        id: wpShell
        anchors {
            left: true
            top: true
            bottom: true
            right: true
        }
        layer: WlrLayer.Background
        Image {
            fillMode: Image.Stretch
            source: Settings.config.currentWall
            width: modelData.width
            height: modelData.height
        }
    }
}

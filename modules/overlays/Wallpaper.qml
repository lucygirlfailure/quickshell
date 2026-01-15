import Quickshell
import QtQuick
import Quickshell.Wayland
import "../../settings/"

Variants {
    id: root
    model: Quickshell.screens
    delegate: WlrLayershell {
        id: wpShell

        required property var modelData
        screen: modelData
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
            width: wpShell.modelData.width
            height: wpShell.modelData.height
        }
    }
}

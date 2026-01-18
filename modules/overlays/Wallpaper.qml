pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import Quickshell.Wayland
import "../../settings/"

Variants {
    id: root
    model: Quickshell.screens
    delegate: WlrLayershell {
        id: wpShell
    aboveWindows: false
exclusionMode:  ExclusionMode.Ignore

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
            anchors.fill: parent
            fillMode: Image.Stretch
            source: Settings.config.currentWall
        }
    }
}

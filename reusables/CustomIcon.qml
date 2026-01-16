import QtQuick
import "../settings/"
import "../"

Text {
    property real fill
    font.family: "Material Symbols Rounded"
    color: Colors.foreground
    font.pixelSize: Settings.config.fontSize + 2
    font.weight: 500
}

import QtQuick
import "../settings/"
import "../"

Text {
    font.weight: 900
    color: Colors.foreground
    font.family: Settings.config.font
    font.pixelSize: Settings.config.fontSize
}

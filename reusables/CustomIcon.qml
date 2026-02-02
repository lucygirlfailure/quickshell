import QtQuick
import qs.settings
import qs

Text {
    verticalAlignment: Text.AlignVCenter
    font.family: "Material Symbols Rounded"
    color: Colors.onSurfaceColor
    font.pixelSize: Settings.config.fontSize + 2
}

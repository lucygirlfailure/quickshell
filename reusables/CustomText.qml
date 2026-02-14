import QtQuick
import qs
import qs.settings

Text {
    color: Colors.primary
    font.family: Settings.config.font
    font.pixelSize: Settings.config.fontSize
    font.weight: Settings.config.fontWeight
}

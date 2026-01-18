import QtQuick
import "../settings/"
import "../"

Text {
    font.family: "Material Symbols Sharp"
    color: Colors.foreground
    font.pixelSize: Settings.config.fontSize + 1
    font.variableAxes: ({
            FILL: 1,
            GRAD: 200,
            wght: 500
        })
}

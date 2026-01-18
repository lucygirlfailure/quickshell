import QtQuick
import "../settings/"
import "../"

Text {
    font.family: "Material Symbols Rounded"
    color: Colors.foreground
    font.pixelSize: Settings.config.fontSize + 1
    font.variableAxes: ({
            FILL: 1,
            GRAD: 100,
            wght: 400
        })
}

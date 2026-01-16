import QtQuick
import "../settings/"
import "../"

Text {
    font.family: "Material Symbols Rounded"
    color: Colors.foreground
    font.pixelSize: Settings.config.fontSize + 1
    font.variableAxes: ({
            GRAD: 200,
            wght: 400
        })
}

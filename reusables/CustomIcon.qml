import QtQuick
import qs.settings
import qs

Text {
    anchors.verticalCenter: parent.verticalCenter
    font.family: "Material Symbols Rounded"
    color: Colors.foreground
    font.pixelSize: Settings.config.fontSize + 1
    font.variableAxes: ({
            FILL: 1,
            GRAD: 100,
            wght: 400
        })
}

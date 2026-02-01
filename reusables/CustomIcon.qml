import QtQuick
import qs.settings
import qs

Text {
    property bool fill: false
    anchors.verticalCenter: parent.verticalCenter
    font.family: "Material Symbols Rounded"
    color: Colors.onSurfaceColor
    font.pixelSize: Settings.config.fontSize + 4
    font.variableAxes: ({
            FILL: fill,
            GRAD: 100,
            opsz: fill ? 48 : 20,
            wght: 400
        })
}

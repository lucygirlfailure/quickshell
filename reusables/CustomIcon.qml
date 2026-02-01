import QtQuick
import qs.settings
import qs

Text {
    verticalAlignment: Text.AlignVCenter
    property bool fill: true
    font.family: fill ? "Material Symbols Rounded Filled" : "Material Symbols Rounded"
    color: Colors.onSurfaceColor
    font.pixelSize: 14
    font.variableAxes: ({
            GRAD: 100,
            opsz: fill ? 48 : 20,
            wght: 700
        })
}

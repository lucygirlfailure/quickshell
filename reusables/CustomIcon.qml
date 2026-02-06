import QtQuick
import qs
import qs.settings

Text {
    property real fill: 0
    font.family: "Material Symbols Rounded"
    color: Colors.onSurfaceColor
    font.pixelSize: Settings.config.fontSize
    font.variableAxes: ({
            FILL: fill,
            GRAD: 200,
            opsz: 36,
            wght: 400
        })
}

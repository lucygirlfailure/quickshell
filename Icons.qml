import QtQuick
import "./modules/settings/"

Text {
    property real fill
    font.family: "Material Symbols Rounded"
    property int grade: 20
    color: Colors.foreground
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            opsz: Settings.fontSize,
            wght: 700
        })
}

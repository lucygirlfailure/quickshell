import QtQuick
import qs.settings
import qs

Text {
    property real fill: 0
    anchors.verticalCenter: parent.verticalCenter
    font.family: "Material Symbols Rounded"
    color: Colors.onSurfaceColor
    font.variableAxes: ({
            FILL: 1,
            GRAD: 200,
            opsz: 0,
            wght: 700
        })
}

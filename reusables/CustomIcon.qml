import QtQuick
import qs.settings
import qs

Text {
    property real fill: 1
    anchors.verticalCenter: parent.verticalCenter
    font.family: "Material Icons Round"
    color: Colors.foreground
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: -25,
            opsz: Settings.config.fontSize,
            wght: Settings.config.fontWeight
        })
}

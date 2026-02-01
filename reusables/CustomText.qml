import QtQuick
import qs
import qs.settings

Text {
    verticalAlignment: Text.AlignVCenter
    color: Colors.onSurfaceColor
    font.family: Settings.config.font
    font.pixelSize: Settings.config.fontSize
    font.variableAxes: ({
            GRAD: 200,
            wght: 400
        })
}

import QtQuick
import qs
import qs.settings

Text {
    color: Colors.foreground
    font.family: Settings.config.font
    font.pixelSize: Settings.config.fontSize
    font.variableAxes: ({
            GRAD: 200,
            wght: 400
        })
}

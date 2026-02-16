import QtQuick
import qs
import qs.settings

Text {
    id: root
    color: Colors.onSurfaceColor
    property real iconSize: 16
    property real fill: 1
    renderType: Text.NativeRendering
    font {
        hintingPreference: Font.PreferNoHinting
        family: "Material Symbols Outlined"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * fill
        variableAxes: {
            "FILL": fill,
            "opsz": iconSize
        }
    }
}

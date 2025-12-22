import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets

Item {
    id: root
    implicitWidth: batRow.implicitWidth + 10
    implicitHeight: batRow.implicitHeight
    Row {
        id: batRow
        anchors.centerIn: parent
        spacing: 0
        IconImage {
            source: "root:/icons/" + UPower.displayDevice.iconName + ".svg"
            implicitWidth: 16
            implicitHeight: 16
        }
        Text {
            id: batteryText
            font.weight: 900
            font.family: Appearance.font
            font.pixelSize: Appearance.fontSize
            color: Colors.foreground
            text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        }
    }
}

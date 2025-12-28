import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import "../../"
import "../settings/"

Item {
    id: root
    implicitWidth: batRow.implicitWidth + 10
    implicitHeight: batRow.implicitHeight
    Row {
        id: batRow
        anchors.centerIn: parent
        spacing: 5
        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            source: "root:/icons/" + UPower.displayDevice.iconName + ".svg"
            width: 12
            height: 12
        }
        Text {
            id: batteryText
            anchors.verticalCenter: parent.verticalCenter
            font.weight: 900
            font.family: Settings.font
            font.pixelSize: Settings.fontSize
            color: Colors.foreground
            text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        }
    }
}

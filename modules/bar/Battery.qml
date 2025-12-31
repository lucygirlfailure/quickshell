import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import "../../"
import "../settings/"
import QtQuick.Layouts

Rectangle {
    id: root
    visible: UPower.displayDevice.isLaptopBattery
    color: "transparent"
    implicitWidth: masterLayout.implicitWidth + 10
    implicitHeight: 34
    ColumnLayout {
        id: masterLayout
        anchors.centerIn: parent
        spacing: 0
        Row {
            spacing: 5
            Text {
                id: topText
                font.weight: 900
                font.family: Settings.font
                font.pixelSize: Settings.fontSize
                text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                color: Colors.foreground
            }
            IconImage {
                anchors.verticalCenter: parent.verticalCenter
                source: "root:/icons/" + UPower.displayDevice.iconName + ".svg"
                width: 12
                height: 12
            }
        }
        Text {
            id: botText
            property var timeToEmpty: UPower.displayDevice.timeToEmpty / 60 / 60
            property var timeToFull: UPower.displayDevice.timeToFull / 60 / 60
            property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
            font.weight: 600
            font.family: Settings.font
            font.pixelSize: Settings.fontSize - 2
            opacity: 0.7
            color: Colors.foreground
            text: isCharging ? timeToFull.toFixed(1) + "h to full" : timeToEmpty.toFixed(1) + "h left"
        }
    }
}

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
            font.weight: 900
            font.family: Settings.font
            font.pixelSize: Settings.fontSize
            color: Colors.foreground
            text: UPower.displayDevice.nativePath
        }
    }
}

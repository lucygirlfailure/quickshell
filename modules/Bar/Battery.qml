import Quickshell
import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import "../../reusables/"
import "../../"
import "../../settings/"

Loader {
    id: batLoader
    active: UPower.displayDevice.isLaptopBattery

    sourceComponent: Item {
        id: root
        implicitWidth: batRow.implicitWidth
        implicitHeight: Settings.config.barHeight
        Rectangle {
            id: batRow
            implicitWidth: batText.implicitWidth + batIcon.implicitWidth + 10
            color: "transparent"

            implicitHeight: Settings.config.barHeight
            Row {
                anchors.centerIn: batRow
                CustomText {
                    id: batText
                    text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                }

                IconImage {
                    id: batIcon
                    anchors.verticalCenter: parent.verticalCenter
                    source: Quickshell.iconPath(UPower.displayDevice.iconName)
                    implicitSize: 12
                }
            }
        }
    }
}

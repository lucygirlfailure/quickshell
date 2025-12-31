pragma ComponentBehavior: Bound
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
            Icons {
                function getBatteryIcon() {
                    if (UPower.displayDevice.percentage < 12) {
                        return "battery_android_0";
                    }
                    if (UPower.displayDevice.percentage < 24) {
                        return "battery_android_1";
                    }
                    if (UPower.displayDevice.percentage < 36) {
                        return "battery_android_2";
                    }
                    if (UPower.displayDevice.percentage < 48) {
                        return "battery_android_3";
                    }
                    if (UPower.displayDevice.percentage < 60) {
                        return "battery_android_4";
                    }
                    if (UPower.displayDevice.percentage < 72) {
                        return "battery_android_5";
                    }
                    if (UPower.displayDevice.percentage < 84) {
                        return "battery_android_6";
                    }
                    if (UPower.displayDevice.percentage > 84) {
                        return "battery_android_full";
                    }
                }
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

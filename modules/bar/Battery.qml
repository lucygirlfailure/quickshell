pragma ComponentBehavior: Bound
import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import "../../"
import "../settings/"
import QtQuick.Layouts

Loader {
    id: root
    visible: UPower.displayDevice.isLaptopBattery
    width: masterLayout.implicitWidth
    height: 34
    ColumnLayout {
        id: masterLayout
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
                property bool isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
                function getBatteryIcon() {
                    if (isCharging) {
                        return "battery_android_frame_bolt";
                    }
                    if (UPower.displayDevice.percentage < 0.12) {
                        return "battery_android_frame_0";
                    }
                    if (UPower.displayDevice.percentage < 0.24) {
                        return "battery_android_frame_1";
                    }
                    if (UPower.displayDevice.percentage < 0.36) {
                        return "battery_android_frame_2";
                    }
                    if (UPower.displayDevice.percentage < 0.48) {
                        return "battery_android_frame_3";
                    }
                    if (UPower.displayDevice.percentage < 0.60) {
                        return "battery_android_frame_4";
                    }
                    if (UPower.displayDevice.percentage < 0.72) {
                        return "battery_android_frame_5";
                    }
                    if (UPower.displayDevice.percentage < 0.84) {
                        return "battery_android_frame_6";
                    }
                    if (UPower.displayDevice.percentage > 0.84) {
                        return "battery_android_full";
                    }
                }
                text: getBatteryIcon()
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
            onTextChanged: console.log(UPower.displayDevice.percentage)
        }
    }
}

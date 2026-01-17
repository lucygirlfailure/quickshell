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

        property bool frame1: UPower.displayDevice.percentage <= 0.16
        property bool frame2: UPower.displayDevice.percentage < 0.32
        property bool frame3: UPower.displayDevice.percentage < 0.48
        property bool frame4: UPower.displayDevice.percentage < 0.74
        property bool frame5: UPower.displayDevice.percentage < 0.90
        property bool frame6: UPower.displayDevice.percentage <= 1

        function getBatteryIcon() {
            if (UPower.displayDevice.state == UPowerDeviceState.Charging) {
                return "battery_android_frame_bolt";
            }
            if (frame1) {
                return "battery_android_frame_1";
            }
            if (frame2) {
                return "battery_android_frame_2";
            }
            if (frame3) {
                return "battery_android_frame_3";
            }
            if (frame4) {
                return "battery_android_frame_4";
            }
            if (frame5) {
                return "battery_android_frame_5";
            }
            if (frame6) {
                return "battery_android_frame_full";
            }
        }

        implicitWidth: batRow.width
        implicitHeight: Settings.config.barHeight

        Row {
            id: batRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            CustomText {
                id: batText
                text: Math.round(UPower.displayDevice.percentage * 100) + "%"
            }
            CustomIcon {
                id: batIcon
                text: root.getBatteryIcon()
            }
        }
    }
}

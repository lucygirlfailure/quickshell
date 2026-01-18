import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import Quickshell
import "../../reusables/"
import "../../settings/"
import "../../"

Loader {
    id: batLoader
    active: UPower.displayDevice.isLaptopBattery
    anchors.verticalCenter: parent.verticalCenter

    sourceComponent: Rectangle {
        id: container
        radius: implicitHeight / 2
        color: Colors.color0
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: root.implicitWidth + 20
        implicitHeight: Settings.config.barHeight - 10
        Item {
            id: root
            anchors.centerIn: parent

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
            function getProfileIcon() {
                if (PowerProfiles.profile.toString() == "2") {
                    return "power-profile-performance-symbolic";
                }
                if (PowerProfiles.profile.toString() == "1") {
                    return "power-profile-balanced-symbolic";
                }
                if (PowerProfiles.profile.toString() == "0") {
                    return "power-profile-power-saver-symbolic";
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
                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    implicitWidth: 12
                    implicitHeight: 12

                    IconImage {
                        id: rawProfileIcon
                        anchors.fill: parent
                        source: Quickshell.iconPath(root.getProfileIcon())
                        visible: false // 🤫 Shh! Hide the dark original
                    }

                    ColorOverlay {
                        anchors.fill: parent
                        source: rawProfileIcon
                        color: "white" // ✨ The magic dye!
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    const modes = [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance];
                    let current = PowerProfiles.profile;
                    let currentIndex = modes.indexOf(current);
                    let nextIndex = (currentIndex + 1) % modes.length;
                    let prevIndex = (currentIndex - 1) % modes.length;
                    if (mouse.button == Qt.LeftButton)
                        PowerProfiles.profile = modes[nextIndex];
                    if (mouse.button == Qt.RightButton)
                        PowerProfiles.profile = modes[prevIndex];
                }
            }
        }
    }
}

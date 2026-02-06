pragma ComponentBehavior: Bound
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import qs.reusables
import qs.settings
import qs

Rectangle {
    id: root
    // This is the background of the entire bar/module
    // You might want to make this transparent if you only want the "pills" to show
    implicitHeight: Settings.config.barHeight - 10
    implicitWidth: mainLayout.implicitWidth + 20
    color: Colors.surfaceContainer
    radius: implicitHeight / 2

    // --- Logic Functions ---
    function getIcon(device) {
        if (device.type === DeviceType.Wifi) {
            for (var i = 0; i < device.networks.values.length; i++) {
                var net = device.networks.values[i];
                if (net.connected) {
                    if (net.signalStrength <= 0.20)
                        return "android_wifi_0_bar";
                    if (net.signalStrength <= 0.40)
                        return "android_wifi_1_bar";
                    if (net.signalStrength <= 0.60)
                        return "android_wifi_2_bar";
                    if (net.signalStrength <= 0.80)
                        return "android_wifi_3_bar";
                    return "android_wifi_4_bar";
                }
            }
            return "wifi_off";
        } else if (device.connected) {
            return "settings_ethernet";
        }
        return "wifi_off";
    }

    function getStatus(device) {
        if (device.type === DeviceType.Wifi) {
            for (var i = 0; i < device.networks.values.length; i++) {
                var net = device.networks.values[i];
                if (net.connected) {
                    return net.name;
                }
            }
            return "Disconnected";
        }
        return device.connected ? "Connected" : "Disconnected";
    }

    // --- Main Layout ---
    RowLayout {
        id: mainLayout
        anchors.centerIn: parent
        spacing: 10 // Space between multiple device pills (if you have ethernet + wifi)

        Repeater {
            id: netRepeater
            model: Networking.devices

            delegate: RowLayout {
                id: innerContent
                required property var modelData
                // THIS fixes the centering issue:
                anchors.centerIn: parent
                spacing: 8

                CustomIcon {
                    id: netIcon
                    Layout.alignment: Qt.AlignVCenter
                    text: root.getIcon(innerContent.modelData)
                }

                CustomText {
                    id: netText
                    Layout.topMargin: 1
                    Layout.alignment: Qt.AlignVCenter
                    text: root.getStatus(innerContent.modelData)
                    // Ensures the text font aligns vertically within its own line-height
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}

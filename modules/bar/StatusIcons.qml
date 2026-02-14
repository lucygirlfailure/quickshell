pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Networking
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs
import qs.reusables
import qs.settings

Rectangle {
    id: root
    implicitWidth: statusLayout.implicitWidth + 10
    implicitHeight: Settings.config.barHeight - 10
    color: Colors.surfaceContainer
    radius: implicitHeight / 2
    property var sink: Pipewire.defaultAudioSink
    property var sinkReady: Pipewire.defaultAudioSink.ready
    property var bat: UPower.displayDevice
    Process {
        id: lowBat
        running: false
        command: ["sh", "-c", "notify-send", "'Low battery!'", "'Plug in your device!'"]
    }
    // wifi functions
    function getIcon(device) {
        if (device.type === DeviceType.Wifi) {
            for (var i = 0; i < device.networks.values.length; i++) {
                var net = device.networks.values[i];
                if (net.connected) {
                    if (net.signalStrength <= 0.20)
                        return "\uf0b0";
                    //signa_wifi_0_bar
                    if (net.signalStrength <= 0.40)
                        return "\uebe4";
                    //network_wifi_1_bar
                    if (net.signalStrength <= 0.60)
                        return "\uebd6";
                    //network_wifi_2_bar
                    if (net.signalStrength <= 0.80)
                        return "\uebe1";
                    //network_wifi_3_bar
                    if (net.signalStrength >= 0.80)
                        return "\ue1d8";
                    // signal_wifi_4_bar
                }
            }
            return "\ue1da";
        } else if (device.connected) {
            return "settings_ethernet";
        }
        return "\ue1da";
        // signal_wifi_off
    }

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
            lowBat.running = true;
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
    // pipewire function
    function getVolumeIcon() {
        // Safety check: if Pipewire is dead or sink is missing
        if (!sink)
            return "volume_off";

        // If muted, show the hush icon
        if (sink.audio.muted)
            return "volume_off";

        // Volume is usually 0.0 to 1.0 (0% to 100%)
        const vol = sink.audio.volume;

        if (vol <= 0.25)
            return "volume_mute";
        if (vol < 0.75)
            return "volume_down";
        if (vol <= 1.00)
            return "volume_up";

        // If it's loud, prepare the ears!
        return "volume_up";
    }
    RowLayout {
        id: statusLayout
        anchors.centerIn: parent
        spacing: 10
        CustomIcon {
            id: volumeIcon
            Layout.alignment: Qt.AlignVCenter
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            text: root.getVolumeIcon()
            MouseArea {
                id: pavuArea
                Process {
                    id: pavuLauncher
                    command: ["sh", "-c", "pavucontrol"]
                }
                anchors.fill: parent
                onClicked: pavuLauncher.exec(pavuLauncher.command)
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
            }
        }

        Repeater {
            id: netRepeater
            Layout.alignment: Qt.AlignVCenter
            model: Networking.devices

            delegate: CustomIcon {
                id: netIcon
                Layout.alignment: Qt.AlignVCenter
                required property var modelData
                text: root.getIcon(modelData)
            }
        }
        CustomIcon {
            id: batIcon
            Layout.alignment: Qt.AlignVCenter
            text: root.getBatteryIcon()
        }
        CustomIcon {
            id: settingsIcon
            text: "settings"
            MouseArea {
                id: settingsArea
                anchors.fill: settingsIcon
                onClicked: {
                    Settings.config.settingsShown = true;
                }
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
            }
        }
    }
}

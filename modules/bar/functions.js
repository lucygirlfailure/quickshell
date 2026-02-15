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

    function getBatteryIcon(perc) {
        if (UPower.displayDevice.state == UPowerDeviceState.Charging) {
            return "battery_android_frame_bolt";
        }
        if (perc <= 0.16) {
            lowBat.running = true;
            return "battery_android_alert";
        }
        if (perc < 0.32) {
            return "battery_android_frame_2";
        }
        if (perc < 0.48) {
            return "battery_android_frame_3";
        }
        if (perc < 0.74) {
            return "battery_android_frame_4";
        }
        if (perc < 0.9) {
            return "battery_android_frame_5";
        }
        if (perc == 1) {
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


import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import "../../reusables/"
import "../../settings/"
import "../../"

Item {
    id: root
    property var sink: Pipewire.defaultAudioSink
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
    implicitWidth: textRow.implicitWidth + 10
    implicitHeight: Settings.config.barHeight
    Row {
        id: textRow
        anchors.centerIn: parent
        spacing: 5
        CustomText {
            id: volumeText
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            text: Pipewire.ready ? Math.round(root.sink.audio.volume * 100) + "%" : "failure"
            opacity: root.sink.audio.muted ? 0.5 : 1
        }
        CustomIcon {
            id: volumeIcon
            opacity: root.sink.audio.muted ? 0.5 : 1
            text: root.getVolumeIcon()
        }
    }
}

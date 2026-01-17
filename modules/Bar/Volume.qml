import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire
import "../../reusables/"
import "../../settings/"
import "../../"

Item {
    id: root
    implicitWidth: textRow.width
    implicitHeight: Settings.config.barHeight
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
    Row {
        id: textRow
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0
        CustomText {
            id: volumeText
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            text: Pipewire.ready ? Math.round(root.sink.audio.volume * 100) + "%" : "failure"
            opacity: Pipewire.ready ? root.sink.audio.muted ? 0.5 : 1 : 0
        }
        CustomIcon {
            id: volumeIcon
            opacity: Pipewire.ready ? root.sink.audio.muted ? 0.5 : 1 : 0
            text: Pipewire.ready ? root.getVolumeIcon() : null
        }
    }
    MouseArea {
        id: pavuArea
        Process {
            id: pavuLauncher
            command: ["sh", "-c", "pavucontrol"]
        }
        anchors.fill: root
        onClicked: pavuLauncher.exec(pavuLauncher.command)
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
    }
}

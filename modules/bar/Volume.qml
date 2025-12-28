import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import "../../"
import "../settings/"

Item {
    id: root
    implicitWidth: volRow.implicitWidth + 10
    implicitHeight: volRow.implicitHeight
    // grab the default speaker (Sink)
    property var sink: Pipewire.defaultAudioSink
    Process {
        id: pavu
        command: ["pavucontrol"] // The command and args list

    }
    MouseArea {
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                pavu.startDetached();
            }
        }
        anchors.fill: parent
        // Scroll to change volume (The fancy stuff!)
    }
    // Logic to pick the correct icon name
    function getVolumeIcon() {
        // Safety check: if Pipewire is dead or sink is missing
        if (!sink)
            return "audio-volume-muted-blocking";

        // If muted, show the hush icon
        if (sink.audio.muted)
            return "audio-volume-muted";

        // Volume is usually 0.0 to 1.0 (0% to 100%)
        const vol = sink.audio.volume;

        if (vol <= 0.0)
            return "audio-volume-low";
        if (vol < 0.33)
            return "audio-volume-low";
        if (vol < 0.66)
            return "audio-volume-medium";

        // If it's loud, prepare the ears!
        return "audio-volume-high";
    }

    Row {
        id: volRow
        anchors.centerIn: parent
        spacing: 5

        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            width: 12
            height: 12

            source: "root:/icons/" + root.getVolumeIcon() + "-symbolic.svg"
        }

        Text {
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            width: 20
            font.weight: 900
            color: Colors.foreground
            font.family: Settings.font
            font.pixelSize: Settings.fontSize
            text: Pipewire.ready ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "0%"
        }
    }
}

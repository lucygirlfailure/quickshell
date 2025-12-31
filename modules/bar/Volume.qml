import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Io
import "../../"
import "../settings/"

Item {
    id: root
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                pavu.startDetached();
            }
        }
    }
    width: styleLayout.implicitWidth + 10
    implicitHeight: 34
    property var sink: Pipewire.defaultAudioSink
    Process {
        id: pavu
        command: ["pavucontrol"] // The command and args list

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

        if (vol <= 0.25)
            return "volume_mute";
        if (vol < 0.75)
            return "volume_down";
        if (vol < 1.00)
            return "volume_up";

        // If it's loud, prepare the ears!
        return "volume_up";
    }

    ColumnLayout {
        id: styleLayout
        anchors.centerIn: parent
        spacing: 0
        Row {
            spacing: 2
            Text {
                PwObjectTracker {
                    objects: Pipewire.ready ? root.sink : []
                }
                font.weight: 900
                color: Colors.foreground
                font.family: Settings.font
                font.pixelSize: Settings.fontSize
                text: Pipewire.ready ? Math.round(root.sink.audio.volume * 100) + "%" : "0%"
            }
            Icons {
                text: root.getVolumeIcon()
            }
        }
        Text {
            font.weight: 900
            color: Colors.foreground
            font.family: Settings.font
            font.pixelSize: Settings.fontSize - 2
            opacity: 0.7
            text: Pipewire.ready ? Pipewire.defaultAudioSink.nickname : "failure"
        }
    }
}

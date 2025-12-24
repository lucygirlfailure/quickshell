import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import qs

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
        cursorShape: Qt.OpenHandCursor
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                // Left Click: Summon the Mixer!
                console.log("Summoning Pavucontrol... Nya!");
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

            // The magic: 'image://theme/' pulls from your system icon theme (Papirus, Adwaita, etc.)
            source: "root:/icons/" + root.getVolumeIcon() + "-symbolic.svg"

            // Optional: Tint the icon if your theme needs it
            // sourceSize: Qt.size(24, 24)
        }

        Text {
            PwObjectTracker {

                objects: Pipewire.defaultAudioSink
            }
            font.weight: 900
            color: Colors.foreground
            font.family: Appearance.font
            font.pixelSize: Appearance.fontSize
            text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%"
        }

        // Click to toggle mute! (Bonus feature)
    }
}

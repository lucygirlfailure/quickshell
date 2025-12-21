import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Item {
    id: root
    implicitWidth: volRow.implicitWidth + 10
    implicitHeight: volRow.implicitHeight
    // grab the default speaker (Sink)
    property var sink: Pipewire.defaultAudioSink

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
            width: 16
            height: 16

            // The magic: 'image://theme/' pulls from your system icon theme (Papirus, Adwaita, etc.)
            source: "root:/icons/" + root.getVolumeIcon() + "-symbolic.svg"

            // Optional: Tint the icon if your theme needs it
            // sourceSize: Qt.size(24, 24)
        }

        Text {
            PwObjectTracker {
                objects: Pipewire.defaultAudioSink
            }
            color: Colors.foreground
            font.family: Appearance.font
            font.pixelSize: Appearance.fontSize
            text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (root.sink) {
                        root.sink.audio.muted = !root.sink.audio.muted;
                    }
                }
                // Scroll to change volume (The fancy stuff!)
                onWheel: wheel => {
                    if (root.sink) {
                        if (wheel.angleDelta.y > 0) {
                            root.sink.audio.volume += 0.05; // Up 5%
                        } else {
                            root.sink.audio.volume -= 0.05; // Down 5%
                        }
                    }
                }
            }
        }

        // Click to toggle mute! (Bonus feature)
    }
}

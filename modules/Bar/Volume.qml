import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import "../../reusables/"
import "../../settings/"
import "../../"

Item {
    id: root
    implicitWidth: volumeText.implicitWidth + 10
    implicitHeight: Settings.config.barHeight
    CustomText {
        id: volumeText
        anchors.centerIn: parent
        PwObjectTracker {
            objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
        }
        text: Pipewire.ready ? Pipewire.defaultAudioSink.audio.muted ? "mut: " + Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "vol: " + Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "failure"
    }
}

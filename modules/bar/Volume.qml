import Quickshell.Io
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Pipewire
import qs.settings
import qs.reusables
import qs

Rectangle {
    id: root
    radius: implicitHeight / 2
    color: pavuArea.containsMouse ? Colors.primaryContainer : Colors.surfaceContainer
    implicitWidth: textRow.implicitWidth + 20
    implicitHeight: Settings.config.barHeight - 10
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
    RowLayout {
        id: textRow
        spacing: 0
        anchors.centerIn: parent
        height: parent.height
        CustomText {
            id: volumeText
            Layout.alignment: Qt.AlignVCenter
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            text: Pipewire.ready ? Math.round(root.sink.audio.volume * 100) + "%" : "failure"
            opacity: Pipewire.ready ? root.sink.audio.muted ? 0.5 : 1 : 0
        }
        CustomIcon {
            id: volumeIcon
            Layout.alignment: Qt.AlignVCenter
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
        anchors.fill: parent
        onClicked: pavuLauncher.exec(pavuLauncher.command)
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }
}

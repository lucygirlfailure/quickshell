import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: root
    visible: root.spotify != null
    radius: implicitHeight / 2
    implicitHeight: Settings.config.barHeight - 10
    color: clickHandler.containsMouse ? Colors.base01 : Colors.base00
    implicitWidth: statusRow.width + 20

    property var spotify: root.getSpotify()
    function getSpotify() {
        for (let i = 0; i < Mpris.players.values.length; i++) {
            if (Mpris.players.values[i].identity.toLowerCase() === "spotify") {
                return Mpris.players.values[i];
            }
        }
        return null;
    }

    RowLayout {
        id: statusRow
        spacing: 5
        anchors.centerIn: parent
        property var combinedText: root.spotify != null ? root.spotify.trackArtist + " - " + root.spotify.trackTitle : ""
        property var status: root.spotify != null ? !root.spotify.isPlaying ? "play_arrow" : "pause" : ""
        CustomText {
            id: mprisText
            Layout.maximumWidth: 300
            Layout.topMargin: 2
            text: root.spotify != null ? parent.combinedText : ""
            elide: Text.ElideRight
        }
        CustomIcon {
            id: mprisStatus
            Layout.topMargin: 2
            text: root.spotify != null ? parent.status : ""
        }
    }
    MouseArea {
        id: clickHandler
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onDoubleClicked: mouse => {
            if (mouse.button == Qt.LeftButton) {
                root.spotify.next();
            }
        }
        onClicked: mouse => {
            if (mouse.button == Qt.RightButton) {
                root.spotify.togglePlaying();
            }
        }
    }
}

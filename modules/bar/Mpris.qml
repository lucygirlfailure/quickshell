import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: container
    visible: root.spotify != null
    radius: implicitHeight / 2
    color: clickHandler.containsMouse ? Colors.primaryContainer : Colors.surfaceContainer
    implicitHeight: Settings.config.barHeight - 10
    implicitWidth: 400
    Item {
        id: root
        width: Math.min(statusRow.implicitWidth, parent.width - 20)
        anchors.centerIn: parent

        property var spotify: root.getSpotify()
        function getSpotify() {
            for (let i = 0; i < Mpris.players.values.length; i++) {
                if (Mpris.players.values[i].identity.toLowerCase() === "spotify") {
                    return Mpris.players.values[i];
                }
            }
            return null;
        }
        implicitWidth: statusRow.implicitWidth
        implicitHeight: statusRow.implicitHeight

        RowLayout {
            id: statusRow
            anchors.fill: parent
            spacing: 5
            anchors.verticalCenter: parent.verticalCenter
            property var combinedText: root.spotify != null ? root.spotify.trackArtist + " - " + root.spotify.trackTitle : ""
            property var status: root.spotify != null ? !root.spotify.isPlaying ? "play_arrow" : "pause" : ""
            CustomText {
                id: mprisText
                Layout.leftMargin: 10
                Layout.fillWidth: true
                Layout.topMargin: 2
                text: root.spotify != null ? parent.combinedText : ""
                elide: Text.ElideRight
                clip: true
                wrapMode: Text.NoWrap
            }
            CustomIcon {
                id: mprisStatus
                Layout.topMargin: 2
                text: root.spotify != null ? parent.status : ""
            }
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

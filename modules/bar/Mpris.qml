// ⚠️ Ensure Colors is imported
// import "../../"
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import qs

RowLayout {
    id: root

    // 1. Let Repeater loop through the ObjectModel for us
    Repeater {
        id: mprisRepeater
        model: Mpris.players

        delegate: RowLayout {
            required property var modelData
            // 2. 🕵️‍♀️ FILTER LOGIC
            // Check if this specific player is Spotify.
            // We verify 'modelData' exists and check the name.
            property bool isSpotify: modelData && modelData.identity.toLowerCase().includes("spotify")

            // 3. 👻 HIDE NON-SPOTIFY PLAYERS
            visible: isSpotify

            // If hidden, take up ZERO space
            Layout.preferredWidth: isSpotify ? Math.min(implicitWidth, 400) : 0
            Layout.fillHeight: true

            // 4. 🎵 USE 'modelData' DIRECTLY
            // property string title: modelData.metadata["xesam:title"] || "No Title"
            // property string artist: modelData.metadata["xesam:artist"] || "Unknown"
            // property string artUrl: modelData.metadata["mpris:artUrl"] || ""
            // property bool isPlaying: modelData.playbackStatus === MprisPlaybackStatus.Playing
            property string title: modelData.trackTitle
            property string artist: modelData.trackArtist
            property string artUrl: modelData.trackArtUrl
            property bool isPlaying: modelData.isPlaying

            spacing: 8

            // 🖼️ ALBUM ART
            Rectangle {
                Layout.preferredHeight: parent.height * 0.8
                Layout.preferredWidth: Layout.preferredHeight
                Layout.alignment: Qt.AlignVCenter

                radius: 4
                color: Colors.background
                clip: true
                visible: parent.visible // Optimization

                Image {
                    anchors.fill: parent
                    source: parent.parent.artUrl // Access property from delegate
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    sourceSize.width: 128
                    sourceSize.height: 128
                }
            }

            // 📝 TEXT INFO
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 0
                visible: parent.visible

                Text {
                    text: parent.parent.title
                    color: Colors.foreground
                    font.bold: true
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    Layout.preferredWidth: implicitWidth
                }

                Text {
                    text: parent.parent.artist
                    color: Colors.foreground
                    opacity: 0.7
                    font.pixelSize: 10
                    Layout.preferredWidth: implicitWidth
                }
            }

            // ⏯️ CONTROLS
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 8
                visible: parent.visible

                // PREV
                Text {
                    text: "󰒮"
                    color: Colors.foreground
                    font.pixelSize: 24
                    MouseArea {
                        anchors.fill: parent
                        // Use modelData to control THIS player
                        onClicked: modelData.previous()
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                // PLAY / PAUSE
                Text {
                    text: parent.parent.isPlaying ? "󰏤" : "󰐊"
                    color: Colors.foreground
                    font.pixelSize: 24
                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.playPause()
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                // NEXT
                Text {
                    text: "󰒭"
                    color: Colors.foreground
                    font.pixelSize: 24
                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.next()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }
}

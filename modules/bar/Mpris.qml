// ⚠️ Ensure Colors is imported
// import "../../"
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../settings/"
import "../../"

Item {
    id: root
    implicitWidth: mprisRepeater.implicitWidth + 10
    implicitHeight: 34

    // 1. Let Repeater loop through the ObjectModel for us
    Repeater {
        id: mprisRepeater
        anchors.verticalCenter: parent.verticalCenter
        model: Mpris.players

        delegate: Item {

            required property var modelData
            implicitHeight: 34
            implicitWidth: delegateLayout.implicitWidth
            MouseArea {
                id: playbackControl
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        console.log("Left button press");
                    }
                    if (mouse.button == Qt.RightButton) {
                        parent.modelData.togglePlaying();
                    }
                }
                onDoubleClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) {
                        parent.modelData.next();
                    }
                }
            }
            RowLayout {
                id: delegateLayout
                // 2. 🕵️‍♀️ FILTER LOGIC
                // Check if this specific player is Spotify.
                // We verify 'modelData' exists and check the name.
                property bool isSpotify: modelData && modelData.identity.toLowerCase().includes("spotify")

                // 3. 👻 HIDE NON-SPOTIFY PLAYERS
                visible: isSpotify

                // If hidden, take up ZERO space
                Layout.preferredWidth: isSpotify ? Math.min(implicitWidth, 400) : 0
                Layout.fillHeight: true

                property string title: modelData.trackTitle
                property string artist: modelData.trackArtist
                property string artUrl: modelData.trackArtUrl
                property bool isPlaying: modelData.isPlaying

                spacing: 10

                // 🖼️ ALBUM ART

                ClippingWrapperRectangle {
                    Layout.alignment: Qt.AlignVCenter

                    radius: 20

                    IconImage {
                        source: delegateLayout.artUrl // Access property from delegate
                        asynchronous: true
                        implicitSize: root.implicitHeight * 0.6
                    }
                }

                // 📝 TEXT INFO
                ColumnLayout {
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0
                    visible: parent.visible

                    Text {
                        text: delegateLayout.title
                        color: Colors.foreground
                        font.bold: true
                        font.pixelSize: Settings.fontSize
                        font.family: Settings.font
                        elide: Text.ElideRight
                        Layout.preferredWidth: implicitWidth
                    }

                    Text {
                        font.pixelSize: Settings.fontSize - 2
                        font.family: Settings.font
                        text: delegateLayout.artist
                        color: Colors.foreground
                        opacity: 0.7
                        Layout.preferredWidth: implicitWidth
                    }
                }
            }
        }
    }
}

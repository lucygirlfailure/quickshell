pragma ComponentBehavior: Bound
import QtQuick
import Qt.labs.folderlistmodel 2.15 // <--- The magic file scanner!
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import "../../"

FloatingWindow {
    id: root
    title: "quickshell-WallSwitcher"
    visible: false
    implicitWidth: 840
    implicitHeight: 640

    GlobalShortcut {
        // This is the "Secret Password" Hyprland will use
        name: "toggle-walls"

        onPressed: {
            // Toggle visibility!
            root.visible = !root.visible;
        }
    }

    // Make it float above everything else
    Text {
        id: titleText
        text: "Wallpapers in " + WallpaperStore.wallDir
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        font.pixelSize: 20
        topPadding: 20
        bottomPadding: 10
        font.family: Appearance.font
        color: Colors.foreground
    }

    color: Colors.background // Dark background

    // 1. The File Scanner
    FolderListModel {
        id: folderModel
        folder: "file:///home/lucy/.walls/" // <--- Your stash!
        nameFilters: ["*.png", "*.jpg", "*.jpeg"]
        showDirs: false
    }

    // 2. The Grid Display
    GridView {
        anchors.top: titleText.bottom // Sit below the title!
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        cellWidth: 200
        cellHeight: 100
        clip: true

        model: folderModel

        delegate: Item {
            required property var modelData
            width: 200
            height: 100

            Image {
                id: wallImage
                width: 180
                height: 90
                anchors.centerIn: parent
                // "fileUrl" is provided by FolderListModel
                source: parent.modelData.fileUrl

                // IMPORTANT: Downscale the image for the thumbnail!
                // If you don't do this, loading 50 4K images will eat your RAM
                sourceSize.width: 140
                sourceSize.height: 90

                fillMode: Image.PreserveAspectCrop
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    let cleanPath = parent.modelData.fileUrl.toString().replace("file://", "");
                    // Update the Singleton!
                    WallpaperStore.currentWall = parent.modelData.fileUrl.toString();
                }
            }
        }
    }
}

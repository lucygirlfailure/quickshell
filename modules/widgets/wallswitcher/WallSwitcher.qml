pragma ComponentBehavior: Bound
import QtQuick.Dialogs
import Quickshell
import qs.settings
import Quickshell.Widgets
import QtQuick
import qs.reusables
import Qt.labs.folderlistmodel 2.10
import Quickshell.Io
import qs
import Quickshell.Hyprland
import QtQuick.Layouts

FloatingWindow {
    id: root
    implicitHeight: 600
    implicitWidth: 900
    title: "qs-wallswitcher"
    visible: Settings.config.wallSwitcherShown
    color: Colors.surface
    onClosed: {
        Settings.config.wallSwitcherShown = false;
    }
    Process {
        id: wallustRunner
        property string cmd: "matugen image " + Settings.config.currentWall + " -t scheme-neutral"
        command: ["sh", "-c", cmd]
    }
    GlobalShortcut {
        name: "showWallSwitcher"
        onPressed: {
            Settings.config.wallSwitcherShown = true;
        }
    }

    ColumnLayout {
        id: windowLayout
        spacing: 10
        anchors.fill: parent

        Rectangle {
            id: textWrapper
            Layout.fillWidth: true
            Layout.margins: 10
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 0
            radius: 14
            implicitHeight: 30
            color: Colors.onPrimaryColor
            CustomText {
                id: titleText
                anchors.centerIn: textWrapper
                text: "Wallpapers in " + Settings.config.wallDir
            }
        }

        Rectangle {
            id: innerWindow
            Layout.topMargin: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 10
            radius: 14
            color: Colors.surfaceContainerLow
            GridView {
                id: gridRoot
                property var columns: Math.floor(gridRoot.width / cellWidth)
                property var usedWidth: columns * cellWidth
                property var emptySpace: width - usedWidth
                property var rows: Math.floor(gridRoot.height / cellHeight)
                property var usedHeight: rows * cellHeight
                property var emptyHeight: height - usedHeight
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                snapMode: GridView.SnapToRow
                cellWidth: 130
                cellHeight: 90
                anchors.fill: innerWindow
                anchors.centerIn: innerWindow
                leftMargin: emptySpace / 2
                topMargin: 20
                model: folderModel
                delegate: fileDelegate
                FolderListModel {
                    id: folderModel
                    folder: Settings.config.wallDir
                    nameFilters: ["*.png", "*.jpg"]
                }
                FontDialog {
                    id: fontPicker
                }

                Component {
                    id: fileDelegate
                    ClippingWrapperRectangle {
                        id: imageRounder
                        implicitHeight: 80
                        implicitWidth: 120
                        required property string filePath
                        radius: 12
                        child: Image {
                            id: wallPreview
                            asynchronous: true
                            source: imageRounder.filePath
                            sourceSize.width: 120
                            sourceSize.height: 80
                            MouseArea {
                                id: wallpaperSetter
                                acceptedButtons: Qt.LeftButton
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    Settings.config.currentWall = imageRounder.filePath;
                                    if (Settings.config.generateScheme) {
                                        wallustRunner.startDetached();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

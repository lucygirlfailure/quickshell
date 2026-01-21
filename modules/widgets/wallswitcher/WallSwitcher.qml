pragma ComponentBehavior: Bound
import Quickshell
import qs.settings
import QtQuick
import Quickshell.Widgets
import qs.reusables
import Qt.labs.folderlistmodel 2.10
import Quickshell.Io
import qs
import Quickshell.Hyprland

FloatingWindow {
    id: root
    visible: Settings.config.wallSwitcherShown
    onClosed: {
        Settings.config.wallSwitcherShown = false;
    }

    Process {
        id: wallustRunner
        property string cmd: "matugen image " + Settings.config.currentWall + " -t scheme-fidelity"
        command: ["sh", "-c", cmd]
    }
    GlobalShortcut {
        name: "showWallSwitcher"
        onPressed: {
            Settings.config.wallSwitcherShown = true;
        }
    }

    implicitHeight: 600
    implicitWidth: 900
    title: "qs-wallswitcher"
    color: Colors.background
    WrapperItem {
        id: innerWindowWrapper
        anchors.centerIn: parent
        anchors.fill: parent
        margin: 20
        child: Rectangle {
            id: innerWindow
            anchors.fill: parent
            anchors.centerIn: parent
            implicitWidth: parent.implicitWidth
            implicitHeight: parent.implicitHeight
            GridView {
                id: gridRoot
                cellWidth: 140
                cellHeight: 100
                topMargin: innerWindowText.implicitHeight + innerWindowText.topPadding
                anchors.fill: parent
                anchors.horizontalCenter: parent.horizontalCenter
                leftMargin: 40
                rightMargin: 20

                FolderListModel {
                    id: folderModel
                    folder: Settings.config.wallDir
                    nameFilters: ["*.png", "*.jpg"]
                }

                Component {
                    id: fileDelegate
                    Image {
                        asynchronous: true
                        cache: true
                        required property string filePath
                        source: filePath
                        width: 120
                        height: 80
                        sourceSize.width: 120
                        sourceSize.height: 80
                        MouseArea {
                            id: wallpaperSetter
                            acceptedButtons: Qt.LeftButton
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Settings.config.currentWall = parent.filePath;
                                if (Settings.config.generateScheme) {
                                    wallustRunner.startDetached();
                                }
                            }
                        }
                    }
                }

                model: folderModel
                delegate: fileDelegate
            }

            radius: 24
            color: Colors.background
            CustomText {
                id: innerWindowText
                topPadding: 10
                text: "Wallpapers in " + Settings.config.wallDir
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

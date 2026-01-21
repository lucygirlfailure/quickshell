pragma ComponentBehavior: Bound
import Quickshell
import qs.settings
import QtQuick
import Quickshell.Widgets
import qs.reusables
import Qt.labs.folderlistmodel 2.10
import Quickshell.Io

FloatingWindow {
    id: wallswitcherWindow
    implicitHeight: 1200
    implicitWidth: 1800
    title: "qs-wallswitcher"
    color: "green"
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
                leftMargin: 20
                rightMargin: 20

                FolderListModel {
                    id: folderModel
                    folder: Settings.config.wallDir
                    nameFilters: ["*.png", "*.jpg"]
                }

                Component {
                    id: fileDelegate
                    Image {
                        required property string filePath
                        source: filePath
                        width: 120
                        height: 80
                        MouseArea {
                            id: wallpaperSetter
                            Process {
                                id: wallustRunner
                                property string cmd: "matugen image " + Settings.config.currentWall + " -t scheme-fidelity"
                                command: ["sh", "-c", cmd]
                            }
                            acceptedButtons: Qt.LeftButton
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Settings.config.currentWall = parent.filePath;
                                wallustRunner.startDetached();
                            }
                        }
                    }
                }

                model: folderModel
                delegate: fileDelegate
            }

            radius: 24
            color: "black"
            CustomText {
                id: innerWindowText
                topPadding: 10
                text: "Hello, world!"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

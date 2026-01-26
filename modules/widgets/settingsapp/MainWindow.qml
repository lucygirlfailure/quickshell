pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import QtQuick.Dialogs
import Quickshell.Widgets
import qs
import qs.settings
import qs.reusables

FloatingWindow {
    id: root
    color: Colors.surface
    title: "qs-settings"
    implicitWidth: 800
    implicitHeight: 600
    ListModel {
        id: pageModel
        ListElement {
            text: "welcomePage"
            source: "WelcomePage.qml"
        }
        ListElement {
            text: "Appearance"
            source: "Appearance.qml"
        }
        ListElement {
            text: "Matugen"
            source: "Matugen.qml"
        }
        ListElement {
            text: "test"
            source: "WelcomePage.qml"
        }
    }
    RowLayout {
        id: windowLayout
        clip: true
        anchors.fill: parent
        spacing: 10

        ClippingWrapperRectangle {
            id: pageWrapper
            Layout.margins: 20
            Layout.fillHeight: true
            Layout.preferredWidth: 200
            Layout.rightMargin: 0
            margin: 20
            color: Colors.surfaceContainerLow
            radius: 12
            ListView {
                id: pageView
                clip: true
                model: pageModel
                delegate: pageDelegate
                Component {
                    id: pageDelegate
                    Rectangle {
                        radius: 24
                        color: ListView.isCurrentItem ? Colors.surfaceContainerHigh : "transparent"
                        implicitHeight: 30
                        implicitWidth: pageWrapper.width - 50
                        required property var modelData
                        required property int index
                        CustomText {
                            id: delegateText
                            leftPadding: 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: parent.modelData.text
                        }
                        MouseArea {
                            id: clickHandler
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            acceptedButtons: Qt.LeftButton
                            onClicked: {
                                contentLoader.source = parent.modelData.source;
                                console.log(parent.index);
                                pageView.currentIndex = parent.index;
                            }
                        }
                    }
                }
            }
        }
        Loader {
            id: contentLoader
            Layout.leftMargin: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 20
            source: pageModel.get(pageView.currentIndex).source
        }
    }
}

import QtQuick
import qs.settings
import QtQuick.Layouts
import qs
import qs.modules.bar
import qs.reusables
import Quickshell.Widgets

Rectangle {
    id: notifyItem
    required property var modelData
    implicitWidth: ListView.view ? ListView.view.width : 300
    implicitHeight: fullLayout.implicitHeight + 20
    color: dismissArea.containsMouse ? Colors.color5 : Colors.color6
    radius: 22
    Timer {
        id: dismissTimer
        interval: 5000
        running: true
        onTriggered: {
            parent.modelData.expire();
        }
    }

    RowLayout {
        id: fullLayout
        anchors.margins: 10
        anchors.fill: parent
        spacing: 10

        ClippingWrapperRectangle {
            id: notiIcon
            radius: notifyItem.radius - notifyItem.radius / 3
            implicitWidth: 64
            color: Colors.color8
            implicitHeight: 64
            visible: notifyItem.modelData.image !== ""
            IconImage {
                source: notifyItem.modelData.image
                visible: notifyItem.modelData.image !== ""
                implicitSize: 64
                asynchronous: true
            }
        }

        ColumnLayout {
            id: textLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 2

            CustomText {
                id: summary
                text: notifyItem.modelData.summary
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
                onTextChanged: {
                    dismissTimer.restart();
                }
            }

            CustomText {
                text: notifyItem.modelData.body
                font.pixelSize: Settings.config.fontSize - 2
                maximumLineCount: 2
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    MouseArea {
        id: dismissArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: notifyItem.modelData.dismiss()
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }
}

import QtQuick
import qs
import qs.reusables
import QtQuick.Layouts
import qs.settings
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick.Dialogs

ClippingWrapperRectangle {
    id: root
    FontDialog {
        id: fontPicker
        title: "qs-fontpicker"
        flags: FontDialog.NoButtons | FontDialog.MonospacedFonts

        onAccepted: {
            Settings.config.font = selectedFont.family;
            Settings.config.fontSize = selectedFont.pointSize;
        }
        onSelectedFontChanged: {
            Settings.config.font = selectedFont.family;
            Settings.config.fontSize = selectedFont.pointSize;
        }
    }
    anchors.centerIn: parent
    clip: true
    color: Colors.surfaceContainerLow
    radius: 12
    margin: 20

    ColumnLayout {
        id: verticalLayout
        Rectangle {
            id: fontWrapper
            radius: 14
            color: Colors.surfaceContainerHigh
            implicitHeight: fontLayout.implicitHeight + 10
            implicitWidth: fontLayout.implicitWidth + 10
            RowLayout {
                id: fontLayout
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                spacing: 10
                CustomText {
                    id: fontText
                    font.bold: true
                    text: "current font: " + Settings.config.font
                }
                Rectangle {
                    id: fontSelector
                    Layout.rightMargin: 5
                    implicitWidth: fontSelectorText.implicitWidth + 20
                    implicitHeight: 20
                    color: Colors.surfaceContainerHigh
                    border.width: 2
                    border.color: Colors.outline
                    radius: 12
                    CustomText {
                        id: fontSelectorText
                        anchors.centerIn: parent
                        text: "Pick Font"
                    }
                    MouseArea {
                        id: fontPickerOpener
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        cursorShape: Qt.PointingHandCursor
                        onClicked: fontPicker.open()
                    }
                }
            }
        }
        Item {
            id: spring
            Layout.fillHeight: true
        }
    }
}

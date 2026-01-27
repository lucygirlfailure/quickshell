import qs.reusables
import qs.settings
import QtQuick
import QtQuick.Layouts
import qs
import QtQuick.Dialogs

Rectangle {
    id: fontButton
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

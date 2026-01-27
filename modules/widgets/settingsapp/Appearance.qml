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
        anchors.margins: 20
        anchors.fill: parent
        ClippingWrapperRectangle {
            id: fontWrapper
            leftMargin: 10
            rightMargin: 10
            implicitWidth: 300
            topLeftRadius: 12
            topRightRadius: 12
            bottomRightRadius: 4
            bottomLeftRadius: 4

            color: Colors.surfaceContainerHigh
            implicitHeight: 30
            child: RowLayout {
                id: fontLayout
                spacing: 40
                CustomText {
                    id: fontText
                    text: "current font: " + Settings.config.font
                    Layout.fillWidth: true
                }
                CustomButton {
                    id: fontPickerButton
                    customText: "pick font"
                    implicitHeight: fontWrapper.implicitHeight - 10
                    onClicked: fontPicker.open()
                }
            }
        }
        ClippingWrapperRectangle {
            id: floatingWrapper
            leftMargin: 10
            rightMargin: 10
            implicitHeight: 30
            implicitWidth: 300
            bottomLeftRadius: 12
            bottomRightRadius: 12
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: floatingToggleLayout
                spacing: 40
                CustomText {
                    id: floatingToggleText
                    text: "top bar floating"
                    Layout.fillWidth: true
                }
                CustomSwitch {
                    implicitHeight: floatingWrapper.implicitHeight - 10
                    implicitWidth: 34
                    onToggled: {
                        Settings.config.floating = !Settings.config.floating;
                    }
                    Layout.rightMargin: 5
                }
            }
        }
        Item {
            id: spring
            Layout.fillHeight: true
        }
    }
}

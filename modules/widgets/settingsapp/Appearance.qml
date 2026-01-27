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
            implicitHeight: 30
            implicitWidth: 300
            RowLayout {
                id: fontLayout
                anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                clip: true
                spacing: 10
                CustomText {
                    id: fontText
                    Layout.leftMargin: 20
                    Layout.alignment: Qt.AlignLeft
                    font.bold: true
                    text: "current font: " + Settings.config.font
                }
            }
        }
        Rectangle {
            id: floatingWrapper
            radius: 14
            color: Colors.surfaceContainerHigh
            implicitHeight: 30
            implicitWidth: 300
            RowLayout {
                id: floatingToggleLayout
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                spacing: 10
                CustomText {
                    id: floatingToggleText
                    Layout.leftMargin: 20
                    Layout.alignment: Qt.AlignLeft
                    font.bold: true
                    text: "top bar floating"
                }
                CustomSwitch {
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 20
                    implicitHeight: 15
                    implicitWidth: 30

                    onToggled: {
                        Settings.config.floating = !Settings.config.floating;
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

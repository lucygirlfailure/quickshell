import QtQuick
import qs
import qs.reusables
import QtQuick.Layouts
import qs.settings
import Quickshell.Widgets
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
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 15
            implicitWidth: parent.implicitWidth - 20
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
                    text: "Current font"
                    Layout.fillWidth: true
                }
                CustomButton {
                    id: fontPickerButton
                    customText: Settings.config.font
                    implicitHeight: fontWrapper.implicitHeight - 10
                    onClicked: fontPicker.open()
                }
            }
        }
        ClippingWrapperRectangle {
            id: floatingWrapper
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 20
            implicitHeight: 30
            bottomLeftRadius: 4
            bottomRightRadius: 4
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: floatingToggleLayout
                spacing: 40
                CustomText {
                    id: floatingToggleText
                    text: "Top bar floating"
                    Layout.fillWidth: true
                }
                CustomSwitch {
                    checked: Settings.config.floating
                    implicitHeight: floatingWrapper.implicitHeight - 10
                    implicitWidth: 34
                    onClicked: {
                        Settings.config.floating = checked;
                    }
                }
            }
        }
        ClippingWrapperRectangle {
            id: screenCornerWrapper
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 20
            implicitHeight: 30
            bottomLeftRadius: 4
            bottomRightRadius: 4
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: screenCornerLayout
                spacing: 40
                CustomText {
                    id: screenCornerText
                    text: "Show screen corners"
                    Layout.fillWidth: true
                }
                CustomSwitch {
                    checked: Settings.config.showScreenCorners
                    implicitHeight: floatingWrapper.implicitHeight - 10
                    implicitWidth: 34
                    onClicked: {
                        Settings.config.showScreenCorners = checked;
                    }
                }
            }
        }
        ClippingWrapperRectangle {
            id: screenCornerRadiusWrapper
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 15
            implicitHeight: 30
            bottomLeftRadius: 4
            bottomRightRadius: 4
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: screenCornerRadiusLayout
                spacing: 5
                CustomText {
                    id: screenCornerRadiusText
                    text: "Screen corner radius"
                    Layout.fillWidth: true
                }
                CustomButton {
                    implicitHeight: screenCornerRadiusWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.screenCornerRadius = Settings.config.screenCornerRadius + 1;
                    }
                    customText: "+"
                    Layout.rightMargin: 0
                }
                CustomText {
                    text: Settings.config.screenCornerRadius
                }

                CustomButton {
                    implicitHeight: barHeightWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.screenCornerRadius = Settings.config.screenCornerRadius - 1;
                    }
                    customText: "-"
                    Layout.rightMargin: 0
                }
            }
        }
        ClippingWrapperRectangle {
            id: barHeightWrapper
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 15
            implicitHeight: 30
            bottomLeftRadius: 4
            bottomRightRadius: 4
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: barControlsLayout
                spacing: 5
                CustomText {
                    id: barControlsText
                    text: "Bar height"
                    Layout.fillWidth: true
                }
                CustomButton {
                    implicitHeight: barHeightWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.barHeight = Settings.config.barHeight + 1;
                    }
                    customText: "+"
                    Layout.rightMargin: 0
                }
                CustomText {
                    text: Settings.config.barHeight
                }

                CustomButton {
                    implicitHeight: barHeightWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.barHeight = Settings.config.barHeight - 1;
                    }
                    customText: "-"
                    Layout.rightMargin: 0
                }
            }
        }
        ClippingWrapperRectangle {
            id: barMarginWrapper
            Layout.fillWidth: true
            leftMargin: 10
            rightMargin: 15
            implicitHeight: 30
            bottomLeftRadius: 4
            bottomRightRadius: 4
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            child: RowLayout {
                id: barMarginLayout
                spacing: 5
                CustomText {
                    id: barMarginText
                    text: "Bar margins"
                    Layout.fillWidth: true
                }
                CustomButton {
                    implicitHeight: barMarginWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.margins = Settings.config.margins + 1;
                    }
                    customText: "+"
                }
                CustomText {
                    text: Settings.config.margins
                }

                CustomButton {
                    implicitHeight: barHeightWrapper.implicitHeight - 10
                    implicitWidth: 20
                    onClicked: {
                        Settings.config.margins = Settings.config.margins - 1;
                    }
                    customText: "-"
                }
            }
        }
        ClippingWrapperRectangle {
            id: translucencyWrapper
            leftMargin: 10
            rightMargin: 10
            implicitHeight: 30
            bottomLeftRadius: 12
            bottomRightRadius: 12
            topRightRadius: 4
            topLeftRadius: 4
            color: Colors.surfaceContainerHigh
            Layout.fillWidth: true
            RowLayout {
                id: translucencyLayout
                CustomText {
                    id: translucencyText
                    text: "Bar trasnlucency"
                    Layout.fillWidth: true
                }
                CustomSlider {
                    from: 0.0
                    to: 1.0
                    value: Settings.config.translucency
                    implicitWidth: 100
                    implicitHeight: translucencyWrapper.implicitHeight - 10
                    onMoved: {
                        Settings.config.translucency = position;
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

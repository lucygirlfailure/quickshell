import QtQuick
import Quickshell.Wayland
import qs
import qs.settings
import qs.reusables
import QtQuick.Dialogs

Rectangle {
    id: container
    radius: implicitHeight / 2
    color: Colors.primaryContainer
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: root.implicitWidth
    implicitHeight: Settings.config.barHeight - 10
    Item {
        id: root
        anchors.centerIn: parent
        readonly property var activeWindow: ToplevelManager.activeToplevel
        implicitWidth: titleText.implicitWidth + 20
        implicitHeight: titleText.implicitHeight
        CustomText {
            id: titleText
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.activeWindow ? root.activeWindow.activated ? root.activeWindow.appId : "Desktop" : "Desktop"
            elide: Text.ElideRight
        }
        MouseArea {
            id: fontOpener
            FontDialog {
                id: fontPicker
                title: "qs-fontpicker"
                flags: FontDialog.NoButtons
                onAccepted: {
                    Settings.config.font = selectedFont.family;
                    Settings.config.fontSize = selectedFont.pointSize;
                }
            }
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                fontPicker.open();
                console.log(fontPicker.selectedFont.family);
            }
        }
    }
}

pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Networking
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs
import qs.reusables
import qs.settings
import "functions.js" as Fn

Rectangle {
    id: root
    implicitWidth: statusLayout.implicitWidth + 20
    implicitHeight: Settings.config.barHeight - 10
    color: Colors.surfaceContainer
    radius: implicitHeight / 2
    required property var barWindow
    required property var barContainer
    required property var margin
    property var sink: Pipewire.defaultAudioSink
    property var sinkReady: Pipewire.defaultAudioSink.ready
    property var bat: UPower.displayDevice
    property var perc: UPower.displayDevice.percentage
    property var vol: Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)
    Process {
        id: lowBat
        running: false
        command: ["sh", "-c", "notify-send", "'Low battery!'", "'Plug in your device!'"]
    }
    PopupWindow {
        id: batPopup
        property string popupText
        implicitWidth: root.width + 5
        implicitHeight: 30
        anchor.window: root.barWindow
        anchor.rect.y: root.barContainer.height + 5
        anchor.rect.x: root.barContainer.width - root.width - root.margin
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            color: Colors.surfaceContainer
            border.width: 5
            border.color: Colors.surface
            radius: Settings.config.floating ? height / 2 : Settings.config.screenCornerRadius

            CustomText {
                anchors.centerIn: parent
                text: batPopup.popupText
            }
        }
    }

    RowLayout {
        id: statusLayout
        anchors.centerIn: parent
        spacing: 10
        CustomIcon {
            id: volumeIcon
            Layout.alignment: Qt.AlignVCenter
            PwObjectTracker {
                objects: Pipewire.ready ? Pipewire.defaultAudioSink : []
            }
            text: Fn.getVolumeIcon()
            MouseArea {
                id: pavuArea
                Process {
                    id: pavuLauncher
                    command: ["sh", "-c", "pavucontrol"]
                }
                anchors.fill: parent
                onClicked: pavuLauncher.exec(pavuLauncher.command)
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    batPopup.visible = true;
                    batPopup.popupText = "Volume: " + root.vol + "%";
                }
                onExited: {
                    batPopup.visible = false;
                }
            }
        }

        Repeater {
            id: netRepeater
            Layout.alignment: Qt.AlignVCenter
            model: Networking.devices

            delegate: CustomIcon {
                id: netIcon
                Layout.alignment: Qt.AlignVCenter
                required property var modelData
                text: Fn.getIcon(modelData)
            }
        }
        CustomIcon {
            id: batIcon
            Layout.alignment: Qt.AlignVCenter
            text: Fn.getBatteryIcon(root.perc)
            MouseArea {
                id: batHover
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                hoverEnabled: true
                onEntered: {
                    batPopup.visible = true;
                    batPopup.popupText = "Battery: " + Math.floor(UPower.displayDevice.percentage * 100) + "%";
                }
                onExited: {
                    batPopup.visible = false;
                }
            }
        }
        CustomIcon {
            id: settingsIcon
            text: "settings"
            MouseArea {
                id: settingsArea
                anchors.fill: settingsIcon
                onClicked: {
                    Settings.config.settingsShown = true;
                }
                acceptedButtons: Qt.LeftButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
            }
        }
    }
}

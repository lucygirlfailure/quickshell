import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets
import "."
import qs

Item {
    id: root
    implicitWidth: batRow.implicitWidth + 10
    implicitHeight: batRow.implicitHeight
    Row {
        id: batRow
        anchors.centerIn: parent
        spacing: 5
        IconImage {
            anchors.verticalCenter: parent.verticalCenter
            source: "root:/icons/" + UPower.displayDevice.iconName + ".svg"
            width: 12
            height: 12
        }
        Text {
            id: batteryText
            anchors.verticalCenter: parent.verticalCenter
            font.weight: 900
            font.family: Appearance.font
            font.pixelSize: Appearance.fontSize
            color: Colors.foreground
            text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        }
        Text {
            id: powerProfile
            text: PowerProfile.toString(PowerProfiles.profile)
            font.weight: 900
            color: Colors.foreground
            font.family: Appearance.font
            font.pixelSize: Appearance.fontSize
        }
    }
    MouseArea {
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.OpenHandCursor
        anchors.fill: parent
        onClicked: {
            const modes = [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance];
            let current = PowerProfiles.profile;
            let currentIndex = modes.indexOf(current);
            let nextIndex = (currentIndex + 1) % modes.length;
            PowerProfiles.profile = modes[nextIndex];
            PowerProfiles.profile = profiles[nextIndex];
        }
    }
}

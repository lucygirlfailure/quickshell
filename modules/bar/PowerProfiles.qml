import QtQuick
import Quickshell.Services.UPower
import qs

Item {
    id: root
    implicitWidth: 80
    Text {
        id: powerProfile
        text: PowerProfile.toString(PowerProfiles.profile)
        font.weight: 900
        color: Colors.foreground
        font.family: Appearance.font
        font.pixelSize: Appearance.fontSize
        anchors.centerIn: parent
        MouseArea {
        cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            anchors.fill: parent
            onClicked: mouse => {
                const modes = [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance];
                let current = PowerProfiles.profile;
                let currentIndex = modes.indexOf(current);
                let nextIndex = (currentIndex + 1) % modes.length;
                let prevIndex = (currentIndex - 1) % modes.length;
                if (mouse.button == Qt.LeftButton)
                    PowerProfiles.profile = modes[nextIndex];
                if (mouse.button == Qt.RightButton)
                    PowerProfiles.profile = modes[prevIndex];
            }
        }
    }
}

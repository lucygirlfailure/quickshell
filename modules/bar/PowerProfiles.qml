import QtQuick
import Quickshell.Services.UPower
import QtQuick.Layouts
import "../settings/"
import "../../"

Item {
    id: root
    width: powerLayout.implicitWidth
    implicitHeight: 34
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
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
    ColumnLayout {
        id: powerLayout
        anchors.centerIn: parent
        spacing: 0
        Text {
            id: powerProfile
            text: PowerProfile.toString(PowerProfiles.profile)
            font.weight: 900
            color: Colors.foreground
            font.family: Settings.font
            font.pixelSize: Settings.fontSize
        }
        Text {
            text: "Profile"
            font.weight: 900
            color: Colors.foreground
            font.family: Settings.font
            font.pixelSize: Settings.fontSize - 2
            opacity: 0.7
        }
    }
}

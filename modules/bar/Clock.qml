import QtQuick
import Quickshell
import qs

Item {
    id: root
    // FIX: Real pixels please!
    implicitWidth: clockText.implicitWidth
    implicitHeight: 30

    Text {
        id: clockText
        anchors.centerIn: parent
        font.weight: 900
        font.family: Appearance.font
        font.pixelSize: Appearance.fontSize
        color: Colors.foreground

        text: Qt.formatDateTime(clock.date, "hh:mm")

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }
}

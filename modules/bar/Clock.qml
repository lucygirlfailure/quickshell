import Quickshell
import QtQuick
import "../../reusables/"
import "../../settings/"

Item {
    id: root
    implicitWidth: clockText.implicitWidth
    implicitHeight: Settings.config.barHeight
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    CustomText {
        id: clockText
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm")
    }
}

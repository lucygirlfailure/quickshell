import Quickshell
import QtQuick
import "../../reusables/"
import "../../settings/"
import "../../"

Rectangle {
    id: container
    radius: implicitHeight / 2
    color: Colors.color0
    anchors.verticalCenter: parent.verticalCenter
    implicitHeight: Settings.config.barHeight - 10
    implicitWidth: root.implicitWidth + 20
    Item {
        id: root
        anchors.centerIn: parent
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
}

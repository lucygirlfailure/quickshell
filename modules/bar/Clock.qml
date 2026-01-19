import Quickshell
import QtQuick
import QtQuick.Controls
import qs
import qs.settings
import qs.reusables

Rectangle {
    id: container
    border.color: Colors.color7
    border.width: 1
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
            property bool showFull
            anchors.centerIn: parent
            text: showFull ? Qt.formatDateTime(clock.date, "hh:mm  /  dd.mm.yy") : Qt.formatDateTime(clock.date, "hh:mm")
        }
    }
    MouseArea {
        id: formatSwitch
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: clockText.showFull = !clockText.showFull
    }
}

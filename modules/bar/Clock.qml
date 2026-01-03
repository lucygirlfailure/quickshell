import QtQuick
import Quickshell
import QtQuick.Layouts
import "../settings/"
import "../../"

Item {
    id: root
    implicitWidth: clockLayout.implicitWidth
    implicitHeight: 35

    ColumnLayout {
        id: clockLayout
        anchors.centerIn: parent
        spacing: 0

        Text {
            id: clockHoursText
            font.weight: 900
            font.family: Settings.font
            font.pixelSize: Settings.fontSize
            color: Colors.foreground

            text: Qt.formatDateTime(clockHours.date, "hh:mm")

            SystemClock {
                id: clockHours
                precision: SystemClock.Minutes
            }
        }
        Text {
            id: clockDateText
            font.weight: 900
            opacity: 0.7
            font.family: Settings.font
            font.pixelSize: Settings.fontSize - 2
            color: Colors.foreground

            text: Qt.formatDateTime(clockDate.date, "dd.MM.yy")

            SystemClock {
                id: clockDate
                precision: SystemClock.Minutes
            }
        }
    }
}

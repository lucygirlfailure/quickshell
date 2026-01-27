import QtQuick
import QtQuick.Controls.Basic
import qs

Switch {
    id: control
    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        implicitWidth: parent.implicitWidth
        implicitHeight: parent.implicitHeight
        radius: 26
        color: Colors.surfaceContainerLow
        border.color: control.checked ? Colors.primary : Colors.onSurfaceColor

        Rectangle {
            implicitHeight: parent.implicitHeight - 6
            implicitWidth: parent.implicitWidth / 2 - 3
            x: control.checked ? parent.width - width - 3 : 3
            anchors.verticalCenter: parent.verticalCenter
            radius: 24
            color: control.down ? Colors.surfaceContainerHighest : Colors.primary
        }
    }
}

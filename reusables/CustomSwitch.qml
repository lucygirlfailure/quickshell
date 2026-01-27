import QtQuick
import QtQuick.Controls.Basic
import qs

Switch {
    id: control
    indicator: Rectangle {
        implicitWidth: parent.implicitWidth
        implicitHeight: parent.implicitHeight
        anchors.verticalCenter: parent.verticalCenter
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: control.checked ? Colors.surfaceContainerHighest : Colors.surfaceContainerHighest
        border.color: control.checked ? Colors.primary : Colors.onSurfaceColor

        Rectangle {
            x: control.checked ? parent.width - width : 0
            anchors.verticalCenter: parent.verticalCenter
            width: parent.implicitWidth / 2
            height: parent.implicitHeight
            radius: 13
            color: control.down ? Colors.surfaceContainerHighest : Colors.primary
            border.color: control.checked ? (control.down ? Colors.onSurfaceColor : Colors.primary) : "#999999"
        }
    }
}

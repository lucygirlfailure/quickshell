import QtQuick
import QtQuick.Controls.Basic
import qs

Slider {
    id: control

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.implicitWidth
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: Colors.surfaceContainerLow

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: Colors.primary
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.implicitHeight - 2
        implicitHeight: control.implicitHeight - 2
        radius: 13
        color: control.pressed ? Colors.primary : Colors.surfaceContainerLow
        border.color: Colors.outline
    }
}

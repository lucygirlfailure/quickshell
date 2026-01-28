import QtQuick
import qs
import QtQuick.Controls.Basic

Button {
    id: control
    property bool showText: false
    property string customText

    contentItem: CustomText {
        id: contentText
        text: control.customText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        id: contentBackground
        border.color: control.down ? Colors.primaryFixed : Colors.primary
        border.width: 1
        radius: parent.implicitHeight / 2
        color: Colors.surfaceContainerLow
    }
}

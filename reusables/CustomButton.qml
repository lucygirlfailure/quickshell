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
        radius: parent.implicitHeight / 2
        color: Colors.surfaceContainerHigh
    }
}

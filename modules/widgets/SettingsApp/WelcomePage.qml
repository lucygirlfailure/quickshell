import QtQuick
import qs
import qs.reusables
import Quickshell.Widgets
import QtQuick.Layouts

ClippingWrapperRectangle {
    id: root
    anchors.centerIn: parent
    clip: true
    color: Colors.surfaceContainerHighest
    radius: 12
    margin: 20
    ColumnLayout {
        id: pageLayout
        spacing: 0
        anchors.top: parent.top
        CustomText {

            text: "Welcome!"
            font.pixelSize: 24
            font.bold: true
        }
        CustomText {

            text: "we love women here"
        }
        Item {
            id: sping
            Layout.fillHeight: true
        }
    }
}

import QtQuick
import Quickshell

Item {
    id: root
    implicitWidth: clockText.text.length + 10
    Text {
        id: clockText
        anchors.centerIn: parent
        text: "sigma balls"
    }
}

import QtQuick
import qs.modules.widgets.settingsapp
import qs.settings
import qs.reusables
import qs

Rectangle {
    id: root
    radius: implicitHeight / 2
    color: pavuArea.containsMouse ? Colors.primaryContainer : Colors.surfaceContainer
    implicitWidth: Settings.config.barHeight - 8
    implicitHeight: Settings.config.barHeight - 10
    CustomIcon {
        id: volumeIcon
        anchors.centerIn: parent
        text: "settings"
    }
    MouseArea {
        id: pavuArea
        anchors.fill: root
        onClicked: {
            Settings.config.settingsShown = true;
        }
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
    }
}

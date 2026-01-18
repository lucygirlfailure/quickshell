pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../settings/"

Variants {
    model: Quickshell.screens
    delegate: WlrLayershell {
        id: root
        required property var modelData
        screen: modelData

        anchors {
            top: true
            right: true
            bottom: true
        }
        margins {
            top: Settings.config.barHeight + Settings.config.margins + 10
            right: 10
            left: 10
        }

        mask: Region {
            item: notifList
        }
        implicitHeight: notifList.contentHeight + 20
        implicitWidth: modelData.width / 8

        layer: WlrLayer.Overlay
        exclusionMode: ExclusionMode.Ignore

        color: "transparent"

        ListView {
            id: notifList
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 10
            height: contentHeight

            model: NotiServer.trackedNotifications
            delegate: NotificationCard {}
        }
    }
}

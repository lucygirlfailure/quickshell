pragma ComponentBehavior: Bound
pragma Singleton
import Quickshell.Services.Notifications
import QtQuick
import Quickshell.Io

NotificationServer {
    bodyMarkupSupported: true
    persistenceSupported: true
    imageSupported: true
    onNotification: notification => {
        notification.tracked = true;
    }
}

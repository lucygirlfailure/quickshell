//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.modules.ipc
import qs.modules.bar
import qs.modules.overlays
import qs.modules.notifications

ShellRoot {
    id: root
    Ipc {}
    Bar {}
    Notification {}
    Wallpaper {}
}

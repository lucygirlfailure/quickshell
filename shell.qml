//@ pragma UseQApplication
import Quickshell
import QtQuick
import "./settings/"
import "./modules/bar/"
import "./modules/overlays/"
import "./modules/ipc/"
import "./modules/notifications/"

ShellRoot {
    id: root
    Bar {}
    Wallpaper {}
    Ipc {}
    Notification {}
}

//@ pragma UseQApplication
import Quickshell
import QtQuick
import "./settings/"
import "./modules/Bar/"
import "./modules/overlays/"

ShellRoot {
    id: root
    Bar {}
    Wallpaper {}
}

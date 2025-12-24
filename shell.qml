//@ pragma UseQApplication
//pragma ComponentBehavior: Bound
pragma ComponentBehavior: Bound
import Quickshell
import "./modules/bar/"
import "./modules/wallpaper/"
import "./modules/notifications/"

Scope {
    WallSwitcher {}
    Variants {
        id: wallVariants
        model: Quickshell.screens
        delegate: Wallpaper {}
    }
    Variants {
        id: barVariants
        model: Quickshell.screens
        delegate: Bar {}
    }
    NotiPopup {}
    Overlay {}
}

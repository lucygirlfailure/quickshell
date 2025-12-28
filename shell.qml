//@ pragma UseQApplication
pragma ComponentBehavior: Bound
import Quickshell
import "./modules/bar/"
import "./modules/wallpaper/"
import "./modules/notifications/"

ShellRoot {
    Variants {
        id: barVariants
        model: Quickshell.screens
        delegate: Bar {
            screen: modelData
        }
    }
    Variants {
        id: overlayVariants
        model: Quickshell.screens
        delegate: Overlay {
            screen: modelData
        }
    }
    Variants {
        id: wallVariants
        model: Quickshell.screens
        delegate: Wallpaper {
            screen: modelData
        }
    }
    WallSwitcher {}
    NotiPopup {}
}

//@ pragma UseQApplication
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import "./modules/bar/"
import "./modules/wallpaper/"
import "./modules/notifications/"

ShellRoot {
    id: shellRoot

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
    Variants {
        id: notiVariants
        model: Quickshell.screens
        delegate: NotiPopup {
            screen: modelData
        }
    }

    WallSwitcher {}
}

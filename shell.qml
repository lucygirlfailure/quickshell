//@ pragma UseQApplication
//pragma ComponentBehavior: Bound
import Quickshell
import qs.modules.bar
import qs.modules.wallpaper
import qs.modules.notifications

Scope {
    WallSwitcher {}
    Variants {
        id: wallVariants
        model: Quickshell.screens
        delegate: Wallpaper {
            screen: wallVariants.modelData
        }
    }
    Variants {
        id: barVariants
        model: Quickshell.screens
        delegate: Bar {
            screen: barVariants.modelData
        }
    }
    NotiPopup {}
}

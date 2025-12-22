//@ pragma UseQApplication
import "./modules/bar/"
import Quickshell
import "./modules/wallpaper/"

Scope {
    WallSwitcher {}
    Variants {
        id: wallVariants
        model: Quickshell.screens
        delegate: Wallpaper {
            screen: modelData
        }
    }
    Variants {
        id: barVariants
        model: Quickshell.screens
        delegate: Bar {
            screen: modelData
        }
    }
}

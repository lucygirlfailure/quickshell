//@ pragma UseQApplication
import qs.modules.bar
import Quickshell
import "./modules/wallpaper"

Scope {
    WallSwitcher {}
    Wallpaper {}
    Variants {
        id: barVariants
        model: Quickshell.screens

        delegate: Bar {
            screen: modelData
        }
    }
}

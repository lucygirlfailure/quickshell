//@ pragma UseQApplication
import qs.modules.bar
import qs.modules.wallpaper
import Quickshell

Scope {
    Variants {
        id: wallpaperVariants
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

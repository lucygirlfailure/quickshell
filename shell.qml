//@ pragma UseQApplication
pragma ComponentBehavior: Bound
import Quickshell
import "./modules/bar/"
import "./modules/wallpaper/"
import "./modules/notifications/"

ShellRoot {
    WallSwitcher {}
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
      model: Quickshell.screens
        id: wallVariants
        delegate: Wallpaper {
            screen: modelData 
        }
    }
    NotiPopup { }
    
}

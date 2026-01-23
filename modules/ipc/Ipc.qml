import QtQuick
import Quickshell.Io
import qs.settings
import QtQuick.Dialogs

Item {
    FontDialog {
        id: fontPicker
        flags: FontDialog.NoButtons
    }

    IpcHandler {
        id: ipcHandler
        target: "settings"
        function setWall(newWall: string): void {
            console.log(Settings.config.generateScheme);
            Settings.config.currentWall = newWall;
            if (Settings.config.generateScheme === true) {
                wallustRunner.startDetached();
            }
        }
        function setFont(newFont: string): void {
            Settings.config.font = newFont;
        }
        function gen(toggle: bool): void {
            Settings.config.generateScheme = toggle;
        }
    }
}

import QtQuick
import Quickshell.Io
import qs.settings
import QtQuick.Dialogs
import Quickshell

Item {
    FontDialog {
        id: fontPicker
        flags: FontDialog.NoButtons
    }

    IpcHandler {
        id: ipcHandler
        target: "settings"
        function setFont(newFont: string): void {
            Settings.config.font = newFont;
        }
        function gen(toggle: bool): void {
            Settings.config.generateScheme = toggle;
        }
        function reload(hard: bool): void {
            Quickshell.reload(hard);
            console.log("reloaded!");
        }
    }
}

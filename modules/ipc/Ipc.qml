import QtQuick
import Quickshell.Io
import qs.settings

Item {
    IpcHandler {
        id: ipcHandler
        target: "settings"
        function setWall(newWall: string): void {
            console.log(Settings.config.generateScheme);
            Settings.config.currentWall = newWall;
            kittyKiller.startDetached();
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
    Process {
        id: wallustRunner
        property string cmd: "wallust run " + Settings.config.currentWall
        command: ["sh", "-c", cmd]
    }
    Process {
        id: kittyKiller
        property string cmd: "pkill -SIGUSR1 kitty"
        command: ["sh", "-c", cmd]
    }
}

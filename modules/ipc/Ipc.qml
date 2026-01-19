import QtQuick
import Quickshell.Io
import qs.settings

Item {
    IpcHandler {
        id: ipcHandler
        target: "settings"
        property bool generate: Settings.config.generateScheme
        function setWall(newWall: string): void {
            Settings.config.currentWall = newWall;
            kittyKiller.exec(kittyKiller.command);
            if (generate) {
                wallustRunner.exec(wallustRunner.command);
            }
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

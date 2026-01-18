import Quickshell
import QtQuick
import Quickshell.Io
import "../../settings/"

Item {
    IpcHandler {
        id: ipcHandler
        target: "settings"
        function setWall(newWall: string): void {
            Settings.config.currentWall = newWall;
            wallustRunner.exec(wallustRunner.command);
        }
    }
    Process {
        id: wallustRunner
        property string cmd: "wallust run " + Settings.config.currentWall
        command: ["sh", "-c", cmd]
        onStarted: console.log("started wallust runner" + command)
    }
    Process {
        id: kittyKiller
        command: ["sh", "-c", "pkill", "-SIGUSR1", "kitty"]
    }
}

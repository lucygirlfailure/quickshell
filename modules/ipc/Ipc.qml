import Quickshell
import QtQuick
import Quickshell.Io
import "../../settings/"

IpcHandler {
    id: ipcHandler
    target: "settings"
    function setWall(newWall: string): void {
        Settings.config.currentWall = newWall;
    }
}

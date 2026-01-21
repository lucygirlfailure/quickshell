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
        property string cmd: "matugen image " + Settings.config.currentWall + " -t scheme-fidelity"
        command: ["sh", "-c", cmd]
    }
}

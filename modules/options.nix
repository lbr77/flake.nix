{ pkgs, ... }:
{
  options = {
    launchd.agents.disable-capslock-delay = {
        command = "/usr/bin/hidutil property --set '{\"CapsLockDelayOverride\":0}'";
        serviceConfig = {
        RunAtLoad = true;
        KeepAlive = false;
        };
    };
  }
}

{ ... }:
{
  programs.dms-shell = {
    enable = true; # info:programs.dms-shell.enable 25.11 (pkg dms-shell 1.5.3)
    systemd.enable = true; # info:programs.dms-shell.systemd.enable 25.11 (default true, explicit: systemd-only autostart)
  };
  services.displayManager.dms-greeter = {
    enable = true; # info:services.displayManager.dms-greeter.enable 25.11
    compositor.name = "niri"; # info:services.displayManager.dms-greeter.compositor.name 25.11
  };
}

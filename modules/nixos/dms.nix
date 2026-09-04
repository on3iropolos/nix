{ ... }:
{
  programs.dms-shell = {
    enable = true; # info:programs.dms-shell.enable 26.05 (pkg dms-shell 1.4.6)
    systemd.enable = true; # info:programs.dms-shell.systemd.enable 26.05 (default true, explicit: systemd-only autostart)
  };
  services.displayManager.dms-greeter = {
    enable = true; # info:services.displayManager.dms-greeter.enable 26.05
    compositor.name = "niri"; # info:services.displayManager.dms-greeter.compositor.name 26.05
  };
}

{ ... }:
{
  programs.dms-shell = {
    enable = true; # info:programs.dms-shell.enable 26.05 (pkg dms-shell 1.4.6)
    systemd.enable = true; # info:programs.dms-shell.systemd.enable 26.05 (default true, explicit: systemd-only autostart)
    systemd.restartIfChanged = true; # info:programs.dms-shell.systemd.restartIfChanged 26.05 (default true, explicit: restart dms.service on package change)
    enableSystemMonitoring = true; # info 26.05 (default true, explicit: dgop bar widgets)
    enableVPN = true; # info 26.05 (default true, explicit: VPN widget)
    enableDynamicTheming = true; # info 26.05 (default true, explicit: matugen templates)
    enableAudioWavelength = true; # info 26.05 (default true, explicit: cava visualizer)
    enableCalendarEvents = true; # info 26.05 (default true, explicit: khal integration)
  };
  services.displayManager.dms-greeter = {
    enable = true; # info:services.displayManager.dms-greeter.enable 26.05
    compositor.name = "niri"; # info:services.displayManager.dms-greeter.compositor.name 26.05
  };
}

{ ... }:
{
  networking.hostName = "stump";
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = false;
  system.stateVersion = "26.05";

  boot.loader.systemd-boot.enable = true; # info:boot.loader.systemd-boot.enable 26.05
  boot.loader.efi.canTouchEfiVariables = true; # info:boot.loader.efi.canTouchEfiVariables 26.05

  networking.networkmanager.enable = true; # info:networking.networkmanager.enable 26.05
  hardware.bluetooth = {
    enable = true; # info:hardware.bluetooth.enable 26.05
    powerOnBoot = true; # info:hardware.bluetooth.powerOnBoot 26.05
  };

  users.users.on3i = {
    isNormalUser = true;
    description = "on3i";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    # Set at install: mkpasswd -m sha-512 > hashedPassword, or nixos-enter + passwd on3i
    # hashedPassword = "<mkpasswd -m sha-512>";
  };

  zramSwap.enable = true; # info:zramSwap.enable 26.05
  services.fstrim.enable = true; # info:services.fstrim.enable 26.05 (default true, explicit for SSD)
  services.power-profiles-daemon.enable = true; # info 26.05; do NOT add thermald (see todo/power-tuning.md)
  services.upower.enable = true; # info:services.upower.enable 26.05

  security.rtkit.enable = true; # info:security.rtkit.enable 26.05
  security.polkit.enable = true; # info:security.polkit.enable 26.05
  services.pipewire = {
    enable = true; # info:services.pipewire.enable 26.05
    alsa.enable = true; # info:services.pipewire.alsa.enable 26.05
    alsa.support32Bit = true; # info:services.pipewire.alsa.support32Bit 26.05
    pulse.enable = true; # info:services.pipewire.pulse.enable 26.05
    wireplumber.enable = true; # info:services.pipewire.wireplumber.enable 26.05
  };
  services.pulseaudio.enable = false; # info:services.pulseaudio.enable 26.05

  xdg.portal.enable = true; # info:xdg.portal.enable 26.05
}

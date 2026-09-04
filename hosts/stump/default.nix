{ ... }:
{
  networking.hostName = "stump";
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = false;
  system.stateVersion = "25.11";

  boot.loader.systemd-boot.enable = true; # info:boot.loader.systemd-boot.enable 25.11
  boot.loader.efi.canTouchEfiVariables = true; # info:boot.loader.efi.canTouchEfiVariables 25.11

  networking.networkmanager.enable = true; # info:networking.networkmanager.enable 25.11
  hardware.bluetooth = {
    enable = true; # info:hardware.bluetooth.enable 25.11
    powerOnBoot = true; # info:hardware.bluetooth.powerOnBoot 25.11
  };

  users.users.on3i = {
    isNormalUser = true;
    description = "on3i";
    extraGroups = [ "wheel" "networkmanager" ];
    # Set at install: mkpasswd -m sha-512 > hashedPassword, or nixos-enter + passwd on3i
    # hashedPassword = "<mkpasswd -m sha-512>";
  };

  zramSwap.enable = true; # info:zramSwap.enable 25.11
  services.fstrim.enable = true; # info:services.fstrim.enable 25.11 (default true, explicit for SSD)
  services.power-profiles-daemon.enable = true; # info 25.11; do NOT add thermald (see todo/power-tuning.md)
  services.upower.enable = true; # info:services.upower.enable 25.11

  security.rtkit.enable = true; # info:security.rtkit.enable 25.11
  security.polkit.enable = true; # info:security.polkit.enable 25.11
  services.pipewire = {
    enable = true; # info:services.pipewire.enable 25.11
    alsa.enable = true; # info:services.pipewire.alsa.enable 25.11
    alsa.support32Bit = true; # info:services.pipewire.alsa.support32Bit 25.11
    pulse.enable = true; # info:services.pipewire.pulse.enable 25.11
    wireplumber.enable = true; # info:services.pipewire.wireplumber.enable 25.11
  };
  services.pulseaudio.enable = false; # info:services.pulseaudio.enable 25.11

  xdg.portal.enable = true; # info:xdg.portal.enable 25.11
}

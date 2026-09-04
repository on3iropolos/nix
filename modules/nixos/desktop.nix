{ pkgs, ... }:
{
  programs.niri.enable = true; # info:programs.niri.enable 25.11

  environment.systemPackages = with pkgs; [
    kitty
    brightnessctl
    pavucontrol
    vscodium # 1.126.04524
    bitwarden-desktop # 2026.8.0
    brave # 1.94.117, MPL-2.0
    git # 2.55.0
    opencode # 1.18.25
  ];
}

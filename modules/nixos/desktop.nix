{ pkgs, ... }:
{
  programs.niri.enable = true; # info:programs.niri.enable 26.05

  environment.systemPackages = with pkgs; [
    kitty
    brightnessctl
    pavucontrol
    vscodium # 1.116.02821
    bitwarden-desktop # 2026.8.0
    brave # 1.94.117, MPL-2.0
    git # 2.54.0
    opencode # 1.15.10
  ];
}

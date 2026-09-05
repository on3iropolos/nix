{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./opencode.nix
  ];

  home.username = "on3i";
  home.homeDirectory = "/home/on3i";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    bitwarden-cli
    gh
    jq
    mcp-nixos
  ];

  programs.git.enable = true;
  programs.gh.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*".AddKeysToAgent = "yes";
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/on3iropolos-ssh";
      };
    };
  };
}

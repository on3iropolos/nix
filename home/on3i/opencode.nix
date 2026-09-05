{ pkgs, ... }:
{
  xdg.configFile."opencode/opencode.jsonc".text =
    ''
      // Managed by nix flake (home/on3i/opencode.nix) — edit there, not here.
    ''
    + builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      mcp.nixos = {
        type = "local";
        command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
        enabled = true;
      };
    };
}

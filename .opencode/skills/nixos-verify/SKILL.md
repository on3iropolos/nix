---
name: nixos-verify
description: Verify any NixOS, home-manager, or nixpkgs option via mcp-nixos before writing. Use when adding or editing any NixOS config.
---

1. `search` the option, then `info` exact attr on channel `26.05`.
2. Check history with `nix_versions` when version-sensitive.
3. Cite as `info:<attr> <channel>` comment in code.
4. Missing option → stop, propose alternatives. Never guess paths.

# AGENTS.md — NixOS flake repo (`stump`, extensible multi-host)

Source of truth for opencode. Repo-managed `.opencode/` owns agents, skills, commands. `~/.config/opencode` is unmanaged.

## Layout
- `flake.nix` — hosts + `formatter=nixfmt-tree`
- `hosts/<name>/{default.nix,hardware.nix,disko.nix}` — per-host (current: `stump`)
- `modules/nixos/*.nix` — shared system modules (`desktop.nix`, `dms.nix`)
- `home/<user>/*.nix` — home-manager as NixOS module
- `todo/*.md` — deferred specs only, never imported by flake
- `pkgs/` — local packages; `secrets/` — gitignored except `.gitkeep`
- `prompts/nixos-stump-master-prompt.md` — archived reference

## Mandatory rules
- Verify EVERY NixOS option via `mcp-nixos` (`search`/`info` on channel `26.05` + `nix_versions` for history) before writing. Never hallucinate attribute paths. Missing option → stop + alternatives.
- `git add -A` before any rebuild; flakes evaluate the working tree.
- `nixpkgs.config.allowUnfree = false` stays. NVIDIA/SOPS/impermanence live in `todo/`, do not implement unless asked.
- Never `push --force`, never commit `secrets/*` or plaintext passwords (`mkpasswd -m sha-512` only).
- Raw nix commands only, no `just` wrapper. See Skills/Commands.
- Cite MCP `info` + channel per option in code comments as `info:<attr> <channel>`.

## Workflows
- Edit → `git add -A && nix flake check` → `nix fmt` → commit.
- Switch: `git add -A && sudo nixos-rebuild switch --flake .#stump` (replace host for multi-host).
- Boot (stage): `git add -A && sudo nixos-rebuild boot --flake .#stump`.
- Update: `nix flake update` then review `flake.lock` diff.
- GC: `sudo nix-collect-garbage -d`. Rollback: `nixos-rebuild switch --rollback`.
- DMS post-install order: `nixos-rebuild switch --flake .#stump` → `dms setup` → `systemctl --user status dms` → `dms doctor`. Never hand-write DMS binds.

## Conventions
- `hosts/<name>/` pattern for new hosts; share via `modules/nixos/`.
- `system.stateVersion` / `home.stateVersion` pinned per host, do not bump casually.
- Keep working generation + LTS kernel fallback.

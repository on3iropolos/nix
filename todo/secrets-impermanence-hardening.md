# TODO: Secrets / Impermanence / Hardening (deferred)

Stable install: `users.users.on3i.hashedPassword` set manually via `mkpasswd`, `passwd -l root` NOT applied, no SOPS.

Later:
- `sops-nix` vs `agenix` decision, `.sops.yaml` + age key from `~/.ssh` (`ssh-to-age`)
- `hashedPasswordFile` + sops secrets, no plaintext, never commit secrets
- Impermanence `/persist` subvolume bind-mounts (currently plain subvolumes)
- `nix-mineral` hardening profile (document breakage, keep working generation)
- `lanzaboote` SecureBoot (replaces `systemd-boot`, setup mode only, TPM2)

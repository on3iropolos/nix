# Bitwarden SSH extraction (deferred)

## Problem
`bw get item on3iropolos-ssh | jq -r .notes` yielded a 69-byte single-line
file — not a valid OpenSSH private key (`Load key ... invalid format`).
Pubkey already on GitHub, private key location in vault unclear
(secure-note `notes` vs custom `fields` vs `attachments`, type-2 item).

## Manual workaround (current)
User places key at `~/.ssh/on3iropolos-ssh` by hand.
`home/on3i/default.nix` points `IdentityFile` there. Never `cat` the file.

## Future work
- Safe probe: `bw get item on3iropolos-ssh | jq` lengths-only
  (`notes_len`, `fields[].name`, `attachments[].fileName`) to locate key.
- If in attachment: `bw get attachment <fileName> --itemid <id>`.
- If single-line escaped: `printf %b` or `jq -r` re-decode before write.
- Consider `rbw` or `bitwarden-cli` + `sops-nix`/`agenix` declarative path;
  document in `secrets/` without committing key material.
- Add `just` to home packages so `just switch` works on fresh installs.

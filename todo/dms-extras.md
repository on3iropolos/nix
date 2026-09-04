# TODO: DMS Extras (deferred — stable uses defaults only)

Stable: `programs.dms-shell = { enable = true; systemd.enable = true; }` + `dms setup` + greeter `compositor.name = "niri"`.

Later via MCP + https://danklinux.com/docs/:
- Feature toggles: `enableSystemMonitoring` (dgop), `enableVPN`, `enableDynamicTheming` (matugen), `enableAudioWavelength` (cava), `enableCalendarEvents` (khal), `enableClipboardPaste` (wtype) + `systemd.restartIfChanged`, `systemd.target`
- Flake override: `dms.url = "github:AvengeMedia/DankMaterialShell/stable"` + `programs.dms-shell.package`
- Plugins: `dms-plugin-registry` flake (`plugins.<id>.enable`) or manual `src = fetchFromGitHub`
- HM declaratives: `programs.dank-material-shell.settings/session/clipboardSettings` (flake HM only) + `dms ipc call settings dump` export
- Greeter theming: `configHome = "/home/on3i"`, `configFiles`, `logs.save`, custom `compositor.customConfig`
- FIDO2 lock: `security.pam.services."dankshell-u2f"` + `security.pam.services.greetd = { u2fAuth/fprintAuth }`

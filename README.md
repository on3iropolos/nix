# stump — Huawei MACH-WX9 · NixOS 26.05 stable wipe-install

Flake-based NixOS config: niri + DankMaterialShell (defaults only), LUKS + btrfs, iGPU-only. Complex items (NVIDIA offload, SOPS, impermanence, DMS extras, power tuning) are specced in `todo/` and intentionally **not** implemented.

| Part | Detail |
|---|---|
| CPU | i7-8550U Kaby Lake-R, UHD 620 iGPU (`modesetting`, `i915`), microcode + redistributable firmware on |
| dGPU | MX150 **disabled** (`nouveau` blacklisted) → `todo/nvidia-offload.md` |
| Disk | `nvme0n1` 476G Samsung PM981 · GPT: 1G ESP `/boot` (`fmask/dmask=0077`), rest LUKS `crypted` (`allowDiscards`) → btrfs `@root/@home/@nix` (`compress=zstd,noatime`) |
| Net | NetworkManager (`wlan0`), bluetooth `powerOnBoot` |
| Audio | PipeWire + ALSA (+32-bit) + Pulse emulation + WirePlumber, rtkit, PulseAudio off |
| Power | power-profiles-daemon + upower + fstrim + zram; **no thermald**, no hibernate |
| Desktop | `programs.niri.enable`, `programs.dms-shell` (`systemd.enable`), greeter `compositor.name="niri"` |
| Locale | `America/Chicago`, `en_US.UTF-8` · `allowUnfree = false` · kernel `pkgs.linuxPackages` (LTS) |

## Install

### 1. Boot the NixOS 26.05 minimal ISO

Flash it to USB, boot UEFI (SecureBoot off), then:

```bash
nmtui    # connect wifi
sudo -i
nix --experimental-features "nix-command flakes" --version
```

### 2. Clone + set password hash

```bash
git clone git@github.com:on3iropolos/nix.git && cd nix
mkpasswd -m sha-512   # paste into hosts/stump/default.nix as hashedPassword
git add -A
```

### 3. Disko — destructive, wipes `nvme0n1`

```bash
nix run github:nix-community/disko -- --mode destroy,format,mount --flake .#stump
mount | grep /mnt     # expect /boot, /, /home, /nix
```

### 4. Install + first boot

```bash
nixos-install --flake .#stump --root /mnt --no-root-passwd
nixos-enter --root /mnt -c 'passwd on3i'   # skip if hashedPassword was set
reboot                                     # pick stump in systemd-boot
nixos-rebuild switch --flake .#stump
```

### 5. Verify hardware + rollback path

```bash
wpctl status                 # audio
bluetoothctl power on        # bt
brightnessctl s 10%          # backlight
systemctl suspend            # resume works
sudo fstrim -Av
nixos-rebuild switch --rollback   # proves fallback generation boots
```

### 6. DMS first-run (mandatory, in order)

```bash
dms setup
systemctl --user status dms
dms doctor
dms ipc call spotlight toggle
```

Greeter → niri → DMS bar. `dms setup` generates `~/.config/niri/config.kdl` with the `dms/colors/layout` includes — never hand-write DMS binds.

## Day-to-day

```bash
just switch   # git add + nixos-rebuild switch
just boot     # stage for next reboot, keep current running
just check    # nix flake check
just update   # nix flake update
just gc       # garbage-collect
```

Always `git add` before rebuild; never `push --force`, never commit secrets.

## Layout

```
flake.nix  hosts/stump/{default,hardware,disko}.nix  modules/nixos/{desktop,dms}.nix
home/on3i/default.nix  todo/  pkgs/  secrets/  prompts/
```

`dms doctor` log: run post-install, paste here.

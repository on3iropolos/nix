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

Fresh wipe-install from the NixOS 26.05 minimal ISO. Destructive: wipes `nvme0n1`.

### 1. Boot ISO

Flash to USB, boot UEFI (SecureBoot off), then:

```bash
nmtui    # connect wifi
sudo -i
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
nix --version
```

### 2. Clone + set password hash

```bash
git clone git@github.com:on3iropolos/nix.git && cd nix
mkpasswd -m sha-512   # paste into hosts/stump/default.nix as hashedPassword
git add -A
```

### 3. Disko + install

```bash
just disko       # destroy,format,mount --flake ".#stump"
mount | grep /mnt     # expect /boot, /, /home, /nix
just install     # nixos-install --root /mnt --no-root-passwd
nixos-enter --root /mnt -c 'passwd on3i'   # skip if hashedPassword was set
reboot                                     # pick stump in systemd-boot
```

### 4. First boot + DMS setup (mandatory, in order)

```bash
nixos-rebuild switch --flake .#stump
dms setup
systemctl --user status dms
dms doctor
dms ipc call spotlight toggle
```

Greeter → niri → DMS bar. `~/.config/niri/config.kdl` is flake-managed (`home/on3i/niri.nix`); `dms setup` generates only the `dms/*.kdl` fragments it includes — never hand-write DMS binds. Set display scale (1.5 on stump) in DMS Settings → Displays; it lives in DMS-owned `dms/outputs.kdl`.

### 5. Verify hardware

```bash
wpctl status                 # audio
bluetoothctl power on        # bt
brightnessctl s 10%          # backlight
systemctl suspend            # resume works
sudo fstrim -Av
```

## Develop

Edit → check → commit. Always `git add` before rebuild; flakes evaluate the working tree.

```bash
just check    # nix flake check
nix fmt       # nixfmt-tree, defined in flake.nix
just update   # nix flake update (bumps flake.lock, review diff)
```

Rules: never `push --force`, never commit secrets (`secrets/` is gitignored except `.gitkeep`). Unfinished work lives in `todo/` with a spec before implementation.

Layout:

```
flake.nix  hosts/stump/{default,hardware,disko}.nix  modules/nixos/{desktop,dms}.nix
home/on3i/default.nix  todo/  pkgs/  secrets/  prompts/
```

## Deploy

Apply config to this machine (`stump`). `switch` activates now, `boot` stages for next reboot.

```bash
just switch   # git add + nixos-rebuild switch --flake ".#stump"
just boot     # stage for next reboot, keep current running
just gc       # garbage-collect old generations
nixos-rebuild switch --rollback   # proves fallback generation boots
```

`dms doctor` log: run post-install, paste here.

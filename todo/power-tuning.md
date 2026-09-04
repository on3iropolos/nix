# TODO: Power / CPU Tuning (deferred)

Stable: `services.power-profiles-daemon.enable = true`, `services.upower.enable = true`, `services.fstrim.enable = true`, `zramSwap.enable = true`, no hibernate on LUKS/btrfs.

Later, pick ONE (ppd vs thermald conflict):
- `services.thermald.enable` + `--adaptive` vs `auto-cpufreq` vs `TLP`
- `hardware.cpu.intel.updateMicrocode = true` — verified, keep
- `intel_pstate` kernelParams verification, `intel_backlight` via `hardware.graphics`
- Hibernate with encrypted swap partition + `boot.resumeDevice` (currently disabled)
- `BAT0` thresholds, suspend-then-hibernate testing

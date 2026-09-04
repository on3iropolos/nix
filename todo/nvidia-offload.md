# TODO: NVIDIA MX150 PRIME Offload (deferred — NOT for stable install)

Stable install uses iGPU only (`hardware.graphics.enable`, `modesetting` driver, `nouveau` blacklisted).
Enable NVIDIA later via MCP verification:

- `hardware.nvidia.modesetting.enable = true` — verified exists
- `hardware.nvidia.powerManagement.enable = true` — verified exists, experimental
- `hardware.nvidia.powerManagement.finegrained = true` — RTD3, verify MX150 support
- `hardware.nvidia.open = false` — MX150 (GP108M Maxwell) needs closed driver, verified option exists
- `hardware.nvidia.prime = { intelBusId = "PCI:0:2:0"; nvidiaBusId = "PCI:1:0:0"; offload = { enable = true; enableOffloadCmd = true; }; }`
- `services.xserver.videoDrivers = [ "modesetting" "nvidia" ]`
- Requires `nixpkgs.config.allowUnfree = true`
- Verify bus IDs: `lspci` shows hex `00:02.0` → decimal `PCI:0:2:0`, `01:00.0` → `PCI:1:0:0`
- Test: `nvidia-offload glxinfo`, backlight, suspend/resume, fallback kernel kept

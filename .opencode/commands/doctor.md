---
description: Post-install DMS and hardware health check
---

Run in order:

```
nixos-rebuild switch --flake .#stump
dms setup
systemctl --user status dms
dms doctor
wpctl status
```

Never hand-write DMS binds. `~/.config/niri/config.kdl` is flake-managed; `dms setup` owns `dms/*.kdl`.

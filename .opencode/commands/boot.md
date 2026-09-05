---
description: Stage this host config for next reboot
agent: nixos-reviewer
---

Host: $ARGUMENTS (default `stump`).

```
git add -A && sudo nixos-rebuild boot --flake .#stump
```

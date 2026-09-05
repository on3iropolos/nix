---
description: Rebuild and switch to this host config now
agent: nixos-reviewer
---

Host: $ARGUMENTS (default `stump`).

Run `nixos-verify` skill for changed options first, then:

```
git add -A && sudo nixos-rebuild switch --flake .#stump
```

Current status: !`git status --short`

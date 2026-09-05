---
description: Update flake inputs and review lock diff
agent: nixos-reviewer
---

```
nix flake update
```

Then review: !`git diff flake.lock | head -100`

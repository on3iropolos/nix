---
name: nixos-check
description: Run nix flake check after staging the worktree. Use after any flake edit.
---

1. `git add -A`
2. `nix flake check`
3. Fix failures before commit. Flakes evaluate the working tree, unstaged changes are invisible.

switch:
  git add -A && sudo nixos-rebuild switch --flake .#stump

boot:
  git add -A && sudo nixos-rebuild boot --flake .#stump

check:
  nix flake check

update:
  nix flake update

gc:
  sudo nix-collect-garbage -d

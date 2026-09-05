disko:
  nix run github:nix-community/disko -- --mode destroy,format,mount --flake .#stump

install:
  nixos-install --flake .#stump --root /mnt --no-root-passwd

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

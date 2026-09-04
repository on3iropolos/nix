{
  description = "stump (Huawei MACH-WX9) — stable wipe-install, niri + DMS defaults";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, disko, nixos-hardware, ... }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    nixosConfigurations.stump = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-pc-laptop
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        ./hosts/stump/default.nix
        ./hosts/stump/disko.nix
        ./hosts/stump/hardware.nix
        ./modules/nixos/desktop.nix
        ./modules/nixos/dms.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.on3i = import ./home/on3i/default.nix;
        }
      ];
    };
  };
}

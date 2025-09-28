{
  description = "my evil NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";
      username = "garo";
    in {
      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };

      homeConfigurations."${username}@macbook" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = darwinSystem; };
        modules = [
          ./home-darwin.nix
        ];
      };
    };
}

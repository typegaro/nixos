{
  description = "Multi-host Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      hosts = {
        main = {
          system = "x86_64-linux";
          configuration = ./hosts/main/configuration.nix;
          username = "garo";
          homeConfig = ./hosts/main/home.nix;
        };
      };

      mkNixosHost = name: { system, configuration, username ? null, homeConfig ? null }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              configuration
            ]
            ++ (if homeConfig == null || username == null then [ ] else [
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = import homeConfig;
              }
            ]);
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = builtins.mapAttrs mkNixosHost hosts;
    };
}

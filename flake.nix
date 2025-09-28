{
  description = "Flake unico: NixOS + macOS Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    linuxSystem = "x86_64-linux";
    darwinSystem = "aarch64-darwin"; # Apple Silicon
  in {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.garo = import ./home.nix; # il tuo HM Linux esistente
        }
      ];
    };

    homeConfigurations."typegaro@macbook" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = darwinSystem;
          config.allowUnfree = true;
        };
        modules = [
          ./mac-home.nix
        ];
        extraSpecialArgs = { inputs = inputs; username = "typegaro"; hostname = "macbook"; };
      };
  };
}
 

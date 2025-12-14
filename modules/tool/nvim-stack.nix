{ lib, config, pkgs, ... }:

let
  packages = with pkgs; [
    neovim
    nodejs_24
    ripgrep
  ];
in {
  options.nvimStack.enable =
    lib.mkEnableOption "Neovim bundle with Node.js and supporting tooling for Mason.";

  config = lib.mkIf config.nvimStack.enable {
    home.packages = packages;
  };
}


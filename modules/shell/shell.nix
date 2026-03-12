{ config, pkgs, ... }:

{
  imports = [
    ./general-config.nix
    ./zsh-config.nix
  ];
}

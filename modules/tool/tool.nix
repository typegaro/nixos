{ config, pkgs, ... }:

{
  imports = [
    ./sxhkd.nix
    ./dunst.nix
  ];
}

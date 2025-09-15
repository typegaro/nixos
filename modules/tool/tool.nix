{ config, pkgs, ... }:

{
  imports = [
    ./sxhkd.nix
    ./dunst.nix
    ./tmux.nix
    ./k9s.nix
  ];
}

{ config, pkgs, ... }:

{
  imports = [
    ./sxhkd.nix
    ./dunst.nix
    ./tmux.nix
    ./k9s.nix
    ./linux-base.nix
    ./nvim-stack.nix
    ./k8s-stack.nix
  ];
}

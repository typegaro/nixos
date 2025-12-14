{ lib, config, pkgs, ... }:

let
  packages = with pkgs; [
    age
    direnv
    eza
    glances
    jq
    lazygit
    nix-direnv
    nix-index
    playerctl
    ripgrep
    sops
    taskwarrior3
    tmux
    toybox
    xclip
  ];
in {
  options.linuxBase.enable =
    lib.mkEnableOption "Bundle of commonly used CLI tooling (ls, search, secrets, etc.).";

  config = lib.mkIf config.linuxBase.enable {
    home.packages = packages;
  };
}


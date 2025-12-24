{ lib, config, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  basePackages = with pkgs; [
    age
    eza
    glances
    jq
    lazygit
    nix-index
    #playerctl
    ripgrep
    sops
    taskwarrior3
    tmux
    toybox
    xclip
  ];

  packages = basePackages
    ++ lib.optionals (!isDarwin) (with pkgs; [
      direnv
      nix-direnv
    ]);
in {
  options.linuxBase.enable =
    lib.mkEnableOption "Bundle of commonly used CLI tooling (ls, search, secrets, etc.).";

  config = lib.mkIf config.linuxBase.enable {
    home.packages = packages;
  };
}

{ config, pkgs, lib, username ? "typegaro", hostname ? "macbook", ... }:
let
  inherit (lib) mkIf mkEnableOption optionals;
  isDarwin = pkgs.stdenv.isDarwin;

  
in
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    git 
    ripgrep 
    fd 
    jq 
    direnv 
    nix-direnv 
    tree 
    tmux 
    fzf 
    eza
    neofetch
  ];

  programs.home-manager.enable = true;

  # Se vuoi riusare i tuoi moduli custom (zsh-config, tmux.enable, ecc.)
  imports = [
    ./modules/shell/shell.nix
    ./modules/term/term.nix
    ./modules/tool/tool.nix
    ./modules/font.nix
  ];

  zsh-config.enable = true;
  tmux.enable = true;
  ghostty.enable = true;


  programs.git = {
    enable = true;
    userName = "typegaro";
    userEmail = "lorenzo.di.giovanni00@gmail.com";
    aliases = { s = "status"; au = "add -u"; cvn = "commit -m\"very nice\""; };
  };
}


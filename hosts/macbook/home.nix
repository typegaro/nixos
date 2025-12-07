{ config, pkgs, ... }:
{
  home.username = "garo";
  home.homeDirectory = "/Users/garo";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.packages = with pkgs; [
    neovim
    brave
    codex
    nodejs_24
    aerospace
    #Terminal tool
    neofetch
    eza
    wget
  ];

  imports = [
    ../../modules/shell/shell.nix
    ../../modules/term/term.nix
    ../../modules/tool/tool.nix
  ];

  zsh-config = {
    enable = true;
    nixSwitchCommand = "nix run home-manager/master -- switch --flake ~/Nix#macbook";
  };

  ghostty = {
    enable = true;
    fontSize = 15;
    backgroundOpacity = 1.0;
  };

  tmux.enable = true;

  programs.git = {
    enable = true;
    userName = "typegaro";
    userEmail = "lorenzo.di.giovanni00@gmail.com";
    aliases = {
      s = "status";
      au = "add -u";
      cvn = "commit -m\"very nice\"";
    };
  };
}

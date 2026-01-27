{ config, pkgs, ... }:
{
  home.username = "lorenzodigiovanni";
  home.homeDirectory = "/Users/lorenzodigiovanni";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  home.sessionPath = [ "/opt/homebrew/bin" ];

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home.packages = with pkgs; [
    neovim
    brave
    codex
    nodejs_24
    aerospace

    devenv

    #Terminal tool
    neofetch
    eza
    wget
  ];

  imports = [
    ../../modules/shell/shell.nix
    ../../modules/term/term.nix
    ../../modules/tool/tool.nix
    ../../modules/leng/leng.nix
  ];

  zsh-config = {
    enable = true;
    nixSwitchCommand = "nix run home-manager/master -- switch --flake ~/Nix#macbook";
  };

  linuxBase.enable = true;
  nvimStack.enable = true;
  k8sStack.enable = false;
  rust.enable = true;

  ghostty = {
    enable = true;
    fontSize = 15;
    backgroundOpacity = 1.0;
  };

  tmux.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "typegaro";
    userEmail = "lorenzo.di.giovanni00@gmail.com";
    aliases = {
      s = "status";
      au = "add -u";
      cvn = "commit -m\"very nice\"";
    };
    extraConfig = {
      diff.tool = "vimdiff";
      merge.tool = "vimdiff";
      mergetool.keepBackup = false;
    };
  };
}

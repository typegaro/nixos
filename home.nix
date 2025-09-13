{ config, pkgs, ... }:

{
  home.username = "garo";
  home.homeDirectory = "/home/garo";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nitrogen
    redshift
    discord
  ];

  imports = [
    ./modules/shell/shell.nix
    ./modules/term/ghostty.nix 
    ./modules/sxhkd.nix
  ];
  zsh-config.enable = true;
  ghostty.enbale = true;

  programs.git = {
    enable = true;
    userName = "typegaro";
    userEmail = "lorenzo.di.giovanni00@gmail.com";
    aliases = {
      gs = "status";
    };
  };
}

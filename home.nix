{ config, pkgs, ... }:
let
  bookmarks = pkgs.callPackage ./pkgs/bookmarks.nix { };
  config= pkgs.callPackage ./pkgs/config.nix { };
  mount = pkgs.callPackage ./pkgs/mount.nix { };
  projects = pkgs.callPackage ./pkgs/projects.nix { };
  run_notify = pkgs.callPackage ./pkgs/run-notify.nix { };
  switch_audio_output = pkgs.callPackage ./pkgs/switch-audio-output.nix { };
  umont = pkgs.callPackage ./pkgs/umont.nix { };
  vpn = pkgs.callPackage ./pkgs/vpn.nix { };
in
{
  home.username = "garo";
  home.homeDirectory = "/home/garo";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    discord
    #code
    nodejs_24
    # utility
    nitrogen
    redshift
    ripgrep
    toybox
  ] ++ [
    bookmarks
    config
    mount
    projects
    run_notify
    switch_audio_output
    umont
    vpn
  ];

  imports = [
    ./modules/shell/shell.nix
    ./modules/term/term.nix
    ./modules/tool/tool.nix
  ];

  zsh-config.enable = true;
  ghostty.enable = true;
  sxhkd.enable = true;
  dunst.enable = true;

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

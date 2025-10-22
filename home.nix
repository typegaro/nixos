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
  services.picom = {
      enable = true;
      vSync = true;
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
  home.packages = with pkgs; [
    discord
    prismlauncher
    flameshot
    localsend
    #code
    nodejs_24
    docker
    poetry
    #tools
    k9s
    awscli2
    opentofu
    helm
    kubectl
    tmux
    taskwarrior3
    jq
    sops
    age
    direnv
    nix-direnv
    codex
    qemu
    virt-manager
    virt-viewer
    spice-gtk
    emacs
    # utility
    nitrogen
    redshift
    ripgrep
    toybox
    xclip
    nix-index
    playerctl
    networkmanager-openvpn
    lmstudio
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
  tmux.enable = true;
  k9s.enable = true;

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

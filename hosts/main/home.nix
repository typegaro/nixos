{ config, pkgs, ... }:
let
  bookmarks = pkgs.callPackage ../../pkgs/bookmarks.nix { };
  config = pkgs.callPackage ../../pkgs/config.nix { };
  mount = pkgs.callPackage ../../pkgs/mount.nix { };
  projects = pkgs.callPackage ../../pkgs/projects.nix { };
  run_notify = pkgs.callPackage ../../pkgs/run-notify.nix { };
  switch_audio_output = pkgs.callPackage ../../pkgs/switch-audio-output.nix { };
  umont = pkgs.callPackage ../../pkgs/umont.nix { };
  vpn = pkgs.callPackage ../../pkgs/vpn.nix { };
in
{
  home.username = "garo";
  home.homeDirectory = "/home/garo";
  home.stateVersion = "25.05";
  services.picom = {
      enable = true;
      vSync = true;
      backend = "glx";
      package = pkgs.picom;
      settings = {
        # Evita tearing e flicker su NVIDIA
        unredir-if-possible = false;
        use-damage = false;
        glx-no-rebind-pixmap = true;
        glx-no-stencil = true;
        # Lascia a 0 per auto-detect refresh, evita mismatch
        refresh-rate = 0;
        blur-method = "kernel";
      };
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
  home.packages = with pkgs; [
    discord
    telegram-desktop
    prismlauncher
    flameshot
    localsend
    docker
    poetry
    qemu
    virt-manager
    virt-viewer
    spice-gtk
    nitrogen
    redshift
    networkmanager-openvpn
    pcmanfm
    lmstudio
    codex
    opencode
    claude-code
    obsidian
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
    ../../modules/shell/shell.nix
    ../../modules/term/term.nix
    ../../modules/tool/tool.nix
  ];

  linuxBase.enable = true;
  nvimStack.enable = true;
  k8sStack.enable = true;

  zsh-config = {
    enable = true;
    nixSwitchCommand = "sudo nixos-rebuild switch --flake ~/Nix";
  };
  ghostty = {
    enable = true;
    fontSize = 14;
    backgroundOpacity = 0.8;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
  sxhkd.enable = true;
  dunst.enable = true;
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
    extraConfig = {
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff";
      mergetool.keepBackup = false;
      difftool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      mergetool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\" -c 'wincmd J | wincmd ='";
    };
  };
}

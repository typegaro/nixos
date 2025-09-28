{ pkgs, ... }:
let
  sharedPackages = with pkgs; [
    nodejs_24
    pnpm
    bun
    poetry
    rust
    cargo
    k9s
    helm
    kubectl
    tmux
    jq
    direnv
    nix-direnv
    ripgrep
  ];
in
{
  home.username = "garo";
  home.homeDirectory = "/Users/garo";
  home.stateVersion = "25.05";

  home.packages = sharedPackages;

  imports = [
    ./modules/shell/shell.nix
    ./modules/term/term.nix
    ./modules/tool/tool.nix
  ];

  zsh-config.enable = true;
  ghostty.enable = true;
  tmux.enable = true;
  k9s.enable = true;

  sxhkd.enable = false;
  dunst.enable = false;

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

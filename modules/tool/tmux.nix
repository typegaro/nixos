{ lib, config, pkgs, ... }:

{
  options."tmux".enable = lib.mkEnableOption "Tmux base configuration";

  config = lib.mkIf config."tmux".enable {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        set -g base-index 1
        setw -g pane-base-index 1
        set -g mouse on
        set -g prefix C-a
        set -g status-bg cyan
        set-option -ga terminal-overrides ",xterm-termite:Tc"
        set -g default-terminal "screen-256color"
        set -as terminal-features ",xterm-256color:RGB"
      '';
    };
  };
}

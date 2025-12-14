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
        set -g status-bg default
        set-option -ga terminal-overrides ",xterm-termite:Tc"
        set -g default-terminal "screen-256color"
        set -as terminal-features ",xterm-256color:RGB"

        # Onedark-inspired, mostly transparent status line
        set -g status on
        set -g status-interval 5
        set -g status-justify left
        set -g status-left-length 0
        set -g status-right-length 120
        set -g status-style "bg=default,fg=#abb2bf"
        set -g status-right '#{?pane_in_mode,#[fg=#e5c07b]COPY#[fg=#5c6370] <U+E0B3> ,}#[fg=#abb2bf]%H:%M #[fg=#5c6370]- #[fg=#abb2bf]%d %b'

        setw -g window-status-format '#[fg=#5c6370]#I #[fg=#5c6370]#W'
        setw -g window-status-current-style 'fg=#61afef,bold'
        setw -g window-status-current-format '#[fg=#61afef]#I #[fg=#61afef]#W'
        setw -g window-status-separator ' '
      '';
    };
  };
}

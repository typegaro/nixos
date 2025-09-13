{ config, lib, pkgs, ... }:

{
  options."ghostty".enable = lib.mkEnableOption "Ghostty terminal configuration";

  config = lib.mkIf config."ghostty".enable {

    # Config di Ghostty tramite file in ~/.config/ghostty/config
    xdg.configFile."ghostty/config".text = ''
      # Font e dimensioni
      font-family = "JetBrainsMono Nerd Font"
      font-size = 12

      # Tema (cambialo se preferisci)
      theme = "Catppuccin Mocha"

      # UI e finestra
      window-decoration = false
      background-opacity = 0.95
      confirm-close = false

      # Comportamento
      cursor-style = block
      scrollback = 100000
      shell-integration = true
    '';
  };
}

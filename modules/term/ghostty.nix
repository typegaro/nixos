{ config, lib, pkgs, ... }:

{
  options."ghostty".enable = lib.mkEnableOption "Ghostty terminal configuration";
  config = lib.mkIf config."ghostty".enable {

    # Config di Ghostty tramite file in ~/.config/ghostty/config
    xdg.configFile."ghostty/config".text = ''
      font-family = "Mononoki Nerd Font"
      font-size = 12
      window-decoration = false
      background-opacity = 0.95
      cursor-style = block
      shell-integration = zsh
    '';
  };
}

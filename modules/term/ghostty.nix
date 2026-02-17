{ config, lib, pkgs, ... }:

let
  cfg = config.ghostty;
in
{
  options.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal configuration";

    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 14;
      description = "Font size used by Ghostty.";
      example = 16;
    };

    backgroundOpacity = lib.mkOption {
      type = lib.types.float;
      default = 1.0;
      description = "Opacity level for Ghostty background (0-1).";
      example = 1.0;
    };
  };

  config = lib.mkIf cfg.enable {

    xdg.configFile."ghostty/config".text = ''
      font-family = "Mononoki Nerd Font"
      font-size = ${toString cfg.fontSize}
      window-decoration = false
      background-opacity = ${toString cfg.backgroundOpacity}
      cursor-style = block
      shell-integration = detect
    '';
  };
}

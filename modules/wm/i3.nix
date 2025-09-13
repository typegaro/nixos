{ lib, pkgs, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.i3;
in
{
  options.i3.enable = mkEnableOption "Enable i3 window manager via Home Manager";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3
      rofi
      i3status
      i3lock
      xclip
      feh
    ];

    xsession.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "ghostty";
        gaps = {
          inner = 8;
          outer = 4;
          smartGaps = true;
          smartBorders = "on";
        };
        fonts = {
          names = [ "JetBrainsMono Nerd Font" "DejaVu Sans" ];
          size = 11.0;
        };

        keybindings = {
          "Mod4+Return" = "exec ghostty";
          "Mod4+d" = "exec rofi -show drun";
          "Mod4+Shift+q" = "kill";
          "Mod4+Shift+r" = "restart";
          "Mod4+Shift+e" = "exec i3-msg exit";

          "Mod4+h" = "focus left";
          "Mod4+j" = "focus down";
          "Mod4+k" = "focus up";
          "Mod4+l" = "focus right";

          "Mod4+Shift+h" = "move left";
          "Mod4+Shift+j" = "move down";
          "Mod4+Shift+k" = "move up";
          "Mod4+Shift+l" = "move right";

          "Mod4+f" = "fullscreen toggle";
          "Mod4+Shift+space" = "floating toggle";
          "Mod4+e" = "layout toggle split";

          "Mod4+1" = "workspace number 1";
          "Mod4+2" = "workspace number 2";
          "Mod4+3" = "workspace number 3";
          "Mod4+4" = "workspace number 4";
          "Mod4+5" = "workspace number 5";
          "Mod4+6" = "workspace number 6";
          "Mod4+7" = "workspace number 7";
          "Mod4+8" = "workspace number 8";
          "Mod4+9" = "workspace number 9";
          "Mod4+0" = "workspace number 10";
          "Mod4+Shift+1" = "move container to workspace number 1";
          "Mod4+Shift+2" = "move container to workspace number 2";
          "Mod4+Shift+3" = "move container to workspace number 3";
          "Mod4+Shift+4" = "move container to workspace number 4";
          "Mod4+Shift+5" = "move container to workspace number 5";
          "Mod4+Shift+6" = "move container to workspace number 6";
          "Mod4+Shift+7" = "move container to workspace number 7";
          "Mod4+Shift+8" = "move container to workspace number 8";
          "Mod4+Shift+9" = "move container to workspace number 9";
          "Mod4+Shift+0" = "move container to workspace number 10";
        };
      };
    };
  };
}

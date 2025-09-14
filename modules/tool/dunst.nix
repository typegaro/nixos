{ config, lib, pkgs, ... }:
{
  options."dunst".enable = lib.mkEnableOption "Dunst notification daemon";

  config = lib.mkIf config."dunst".enable {
    services.dunst = {
      enable = true;
      package = pkgs.dunst;

      settings = {
        global = {
          monitor = 0;
          follow = "mouse";

          width = 300;
          # Sintassi nuova: (min, max). Dinamico fino a 300px.
          height = "(0, 300)";

          origin = "top-right";
          # Sintassi nuova: (x, y)
          offset = "(16, 16)";

          # Look minimal
          frame_width = 0;
          separator_color = "auto";
          separator_height = 1;

          padding = 8;
          horizontal_padding = 10;
          line_height = 0;
          corner_radius = 4;
          font = "JetBrainsMono Nerd Font 10";

          # Niente markup e format semplice.
          markup = "yes";
          format = ''%s\n%b'';
          alignment = "left";
          ellipsize = "end";

          show_indicators = "no";
          word_wrap = "yes";
          ignore_newline = "no";
          show_age_threshold = 60;

          # Niente icone per essere minimal
          icon_position = "On";

          browser = "${pkgs.xdg-utils}/bin/xdg-open";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";

          mouse_left_click = "close_current";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_all";
        };

        # One Dark
        urgency_low = {
          background = "#282c34";
          foreground = "#abb2bf";
          frame_color = "#61afef";
          timeout = 3;
        };

        urgency_normal = {
          background = "#282c34";
          foreground = "#abb2bf";
          frame_color = "#61afef";
          timeout = 5;
        };

        urgency_critical = {
          background = "#282c34";
          foreground = "#e06c75";
          frame_color = "#e06c75";
          timeout = 0;
        };
      };
    };
  };
}

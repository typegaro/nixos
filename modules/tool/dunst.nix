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
          height = 10;
          origin = "top-right";
          offset = "20x20";
          scale = 0;
          transparency = 0;
          frame_color = "#89b4fa";
          frame_width = 2;
          separator_color = "auto";
          line_height = 0;
          idle_threshold = 120;
          font = "JetBrainsMono Nerd Font 10";
          corner_radius = 6;
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          show_indicators = "yes";
          word_wrap = "yes";
          ignore_newline = "no";
          show_age_threshold = 60;
          browser = "${pkgs.xdg-utils}/bin/xdg-open";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst";
          icon_theme = "Papirus-Dark";
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_all";
        };

        urgency_low = {
          background = "#1e1e2e";
          foreground = "#a6adc8";
          frame_color = "#89b4fa";
          timeout = 3;
        };

        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
          timeout = 5;
        };

        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#f38ba8";
          frame_color = "#f38ba8";
          timeout = 0;
        };
      };
    };
  };
}

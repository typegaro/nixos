{ lib, config, pkgs, ... }:

{
  options."sxhkd".enable = lib.mkEnableOption "SXHKD keybindings";
  config = lib.mkIf config."sxhkd".enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "alt + shift + Return" = ''~/Scripts/projects.sh'';

        "alt + w" = ''~/Scripts/run-notify.sh "brave" "Brave starting"'';

        "alt + shift + w" = ''~/Scripts/bookmarks.sh'';

        "alt + Escape" = ''
          pkill -USR1 -x sxhkd
          sxhkd
        '';

        "alt + shift + e" = ''~/Scripts/config.sh'';

        "alt + shift + m; {space,j,k,p,d,s}" = ''{playerctl play-pause,~/Scripts/run-notify.sh "amixer set Master 5%- unmute" "Volume down",~/Scripts/run-notify.sh "amixer set Master 5%+ unmute" "Volume up", mpv --no-video --volume=50 "$(xclip -selection clipboard -o)",~/Scripts/run-notify.sh "killall mpv" "mpv killed",~/Scripts/switch-audio-output.sh}'';

        "alt + shift + d; {m,u}" = ''{~/Scripts/mount.sh,~/Scripts/umount.sh}'';

        "alt + shift + f" = ''alacritty -e lf'';

        "alt + shift + v" = ''~/Scripts/vpn.sh'';

        "alt + shift + t; {m}" = ''{pactl set-source-mute @DEFAULT_SOURCE@ toggle}'';
      };
    };
  };
}

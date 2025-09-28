{ lib, config, pkgs, ... }:

{
  options."sxhkd".enable = lib.mkEnableOption "SXHKD keybindings";
  config = lib.mkIf (config."sxhkd".enable && pkgs.stdenv.hostPlatform.isLinux) {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "alt + shift + Return" = ''projects'';

        "alt + w" = ''run-notify "brave" "Brave starting"'';

        "alt + shift + w" = ''bookmarks'';

        "alt + Escape" = ''
          pkill -USR1 -x sxhkd
          sxhkd
        '';

        "alt + shift + e" = ''config'';

        "alt + shift + m; {space,j,k,p,d,s}" = ''{playerctl play-pause,run-notify "amixer set Master 5%- unmute" "Volume down",run-notify "amixer set Master 5%+ unmute" "Volume up", mpv --no-video --volume=50 "$(xclip -selection clipboard -o)",run-notify "killall mpv" "mpv killed",switch-audio-output}'';

        "alt + shift + d; {m,u}" = ''{mount,umount}'';

        "alt + shift + v" = ''vpn'';

        "alt + shift + t; {m}" = ''{pactl set-source-mute @DEFAULT_SOURCE@ toggle}'';
      };
    };
  };
}

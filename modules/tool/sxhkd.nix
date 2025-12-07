{ lib, config, pkgs, ... }:

let
  cfg = config.sxhkd;

  bookmarksPkg = pkgs.callPackage ../../pkgs/bookmarks.nix { };
  configPkg = pkgs.callPackage ../../pkgs/config.nix { };
  mountPkg = pkgs.callPackage ../../pkgs/mount.nix { };
  projectsPkg = pkgs.callPackage ../../pkgs/projects.nix { };
  runNotifyPkg = pkgs.callPackage ../../pkgs/run-notify.nix { };
  switchAudioOutputPkg = pkgs.callPackage ../../pkgs/switch-audio-output.nix { };
  umontPkg = pkgs.callPackage ../../pkgs/umont.nix { };
  vpnPkg = pkgs.callPackage ../../pkgs/vpn.nix { };

  sxhkdPackages =
    (with pkgs; [
      sxhkd
      playerctl
      alsa-utils
      mpv
      xclip
      pcmanfm
    ]) ++ [
      bookmarksPkg
      configPkg
      mountPkg
      projectsPkg
      runNotifyPkg
      switchAudioOutputPkg
      umontPkg
      vpnPkg
    ];
in
{
  options.sxhkd = {
    enable = lib.mkEnableOption "SXHKD keybindings";

    installPackages = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install the packages referenced by the default keybindings.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
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

          "alt + shift + t" = ''pcmanfm'';
        };
      };
    })

    (lib.mkIf (cfg.enable && cfg.installPackages) {
      home.packages = sxhkdPackages;
    })
  ];
}

{ config, lib, pkgs, ... }:

let
  cfg = config.pipewire;
  types = lib.types;
 in {
  options.pipewire = {
    enable = lib.mkEnableOption "Enable PipeWire audio stack (replaces PulseAudio)";

    lowLatency = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Enable a low-latency PipeWire configuration (smaller quantum).";
    };

    extraPackages = lib.mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ pavucontrol pamixer ];
      description = "GUI/CLI helper packages to manage audio (added to systemPackages).";
    };
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;    
    hardware.pulseaudio.enable = false; 

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig = lib.mkIf cfg.lowLatency {
        pipewire."10-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [ 44100 48000 96000 ];
            "default.clock.quantum" = 128;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 8192;
          };
        };
      };
    };

    environment.systemPackages = cfg.extraPackages ++ (with pkgs; [
      wireplumber
      pipewire
      alsa-utils
    ]);
  };
}

{ config, lib, pkgs, ... }:

let
  types = lib.types;
  cfg = config.virtualbox;
in
{
  options.virtualbox = {
    enable = lib.mkEnableOption "VirtualBox host support";

    user = lib.mkOption {
      type = types.str;
      default = "garo";
      description = "User to add to vboxusers group.";
    };

    enableExtensionPack = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Enable the VirtualBox Extension Pack (unfree).";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = cfg.enableExtensionPack;
    };

    users.users.${cfg.user}.extraGroups = [ "vboxusers" ];
  };
}

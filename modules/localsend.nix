{ config, lib, pkgs, ... }:

{
  options."localsend".enable = lib.mkEnableOption "Enable LocalSend (opens firewall)";

  config = lib.mkIf config."localsend".enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}

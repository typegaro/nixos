{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting.enable = true;         
    nvidiaSettings = true;              
    open = false;                       
    powerManagement.enable = lib.mkDefault false;
  };

  hardware.nvidia-container-toolkit.enable = true;

}

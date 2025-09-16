{ config, pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Abilita l'interfaccia grafica Blueman per gestire dispositivi Bluetooth
  services.blueman.enable = true;
}

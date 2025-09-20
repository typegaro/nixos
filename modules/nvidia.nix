{ config, pkgs, lib, ... }:
{
  # Driver NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  # OpenGL / Vulkan + 32bit per Steam / Proton
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production; # ramo stabile/production
    modesetting.enable = true;          # abilita nvidia-drm.modeset=1 per KMS
    nvidiaSettings = true;              # tool grafico nvidia-settings
    open = lib.mkDefault false;         # puoi mettere true se GPU recente supporta moduli open
    powerManagement.enable = lib.mkDefault false; # true se laptop (risparmio energetico)
    # powerManagement.finegrained = true;         # opzionale, più aggressivo
  };

  # Supporto container (CUDA ecc.) opzionale ma utile
  hardware.nvidia-container-toolkit.enable = true;

  # PRIME (solo se laptop ibrido) - lascia commentato se desktop ONLY NVIDIA
  # hardware.nvidia.prime = {
  #   offload.enable = true;
  #   intelBusId = "PCI:0:2:0";   # sostituisci dopo lspci
  #   nvidiaBusId = "PCI:1:0:0";  # sostituisci dopo lspci
  # };
  # environment.variables = {
  #   __NV_PRIME_RENDER_OFFLOAD = "1";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  # };
}

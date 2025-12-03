{ config, pkgs, lib, ... }:
{
  # Libvirt + QEMU/KVM backend
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;     # enable TPM emulation for modern guests
      # runAsRoot = false;     # uncomment if you want user-mode qemu
    };
  };

  # Optional: allow USB redirection in SPICE clients
  virtualisation.spiceUSBRedirection.enable = true;

  # Virt-manager uses dconf to store settings; Polkit for auth
  programs.dconf.enable = true;
  security.polkit.enable = true;

  # Helpful host-side agent for SPICE (clipboard, resolution, etc.)
  services.spice-vdagentd.enable = true;

  # Trust the default libvirt bridge to avoid local firewall issues
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}

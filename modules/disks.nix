{ config, lib, pkgs, ... }:

{
  # Abilita supporto btrfs a livello di boot
  boot.supportedFilesystems = [ "btrfs" ];

  # Monta il disco da 1TB in /data.
  # Usiamo un percorso stabile by-id basato su modello+seriale.
  # Se il link differisce sul tuo sistema, possiamo correggerlo oppure usare by-uuid.
  fileSystems."/data" = {
    # Usare UUID è più robusto: non dipende dai nomi dei device o dai symlink by-id.
    device = "/dev/disk/by-uuid/1f09fa98-a521-432e-a9ae-bcdc0dbd579f";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "autodefrag"
      "noatime"
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };

  # Garantisce che la directory di mount esista anche prima del boot
  systemd.tmpfiles.rules = [ "d /data 0755 root root -" ];
}

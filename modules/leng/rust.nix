{ lib, config, pkgs, ... }:

{
  options.rust = {
    enable = lib.mkEnableOption "Rust toolchain (rustup, cargo, rust-analyzer, etc.).";
    installRustup = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Adds rustup alongside the Nixpkgs Rust toolchain. Disabled by default
        to avoid duplicate cargo installations in the build environment.
      '';
    };
  };

  config = lib.mkIf config.rust.enable {
    home.packages =
      (with pkgs; [
        cargo
        rustc
        clippy
        rustfmt
        rust-analyzer
      ])
      ++ lib.optional config.rust.installRustup pkgs.rustup;
  };
}

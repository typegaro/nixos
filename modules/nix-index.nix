{ lib, config, inputs, ... }:

let
  hasNixIndexDatabase = builtins.hasAttr "nix-index-database" inputs;
in
{
  options.nixIndex.enable =
    lib.mkEnableOption "nix-index with nix-index-database + comma";

  imports = lib.optional hasNixIndexDatabase inputs.nix-index-database.nixosModules.nix-index;

  config = lib.mkIf config.nixIndex.enable {
    programs = {
      command-not-found.enable = false;
      nix-index = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    } // lib.optionalAttrs hasNixIndexDatabase {
      nix-index-database.comma.enable = true;
    };
  };
}

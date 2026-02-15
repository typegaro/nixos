{ lib, config, pkgs, ... }:

let
  packages = [
    (pkgs.python3.withPackages (ps: with ps; [
      jupyter
      ipykernel
      ipython
      numpy
      pandas
      matplotlib
    ]))
  ];
in {
  options.jupyterNotebook.enable =
    lib.mkEnableOption "Jupyter Notebook environment with Python dependencies.";

  config = lib.mkIf config.jupyterNotebook.enable {
    home.packages = packages;
  };
}

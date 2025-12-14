{ lib, config, pkgs, ... }:

let
  packages = with pkgs; [
    awscli2
    helm
    k9s
    kubectl
    opentofu
  ];
in {
  options.k8sStack.enable =
    lib.mkEnableOption "Kubernetes stack (kubectl/helm/k9s/opentofu/awscli).";

  config = lib.mkMerge [
    { k9s.enable = lib.mkDefault config.k8sStack.enable; }
    (lib.mkIf config.k8sStack.enable {
      home.packages = packages;
    })
  ];
}


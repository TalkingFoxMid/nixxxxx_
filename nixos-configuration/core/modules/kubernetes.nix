{config, pkgs, lib, ...}:
{
    environment.systemPackages = with pkgs; [
      kubectl
      kubernetes-helm
    ];
}

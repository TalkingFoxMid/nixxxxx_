{ config, pkgs, lib, ... }:
{
  # Enable Docker virtualization
  virtualisation = {
    podman = {
      enable = true;
      extraPackages = [ pkgs.catatonit ];
    };
  };
  
  hardware.nvidia-container-toolkit.enable = true;
  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    docker-compose # start group of containers for dev
    distrobox
  ];
}

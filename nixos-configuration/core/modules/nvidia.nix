{ config, pkgs, lib, ... }:
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    egl-wayland
    cudaPackages.cuda_nvcc
    nvidia-docker
  ];

  hardware.graphics.enable = true;
  services.xserver.displayManager.sessionCommands = ''
    nvidia-cdi-setup
  '';

}

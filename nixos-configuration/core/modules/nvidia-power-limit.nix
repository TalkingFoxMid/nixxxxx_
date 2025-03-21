{ config, pkgs, lib, ... }:
{
  # Create a systemd service to set NVIDIA GPU power limit on boot
  systemd.services.nvidia-power-limit = {
    description = "Set NVIDIA GPU Power Limit";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "nvidia-power-limit" ''
        # Set power limit to 450W for GPU 0
        ${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi -i 0 -pl 450
      ''}";
      RemainAfterExit = true;
    };
  };
}


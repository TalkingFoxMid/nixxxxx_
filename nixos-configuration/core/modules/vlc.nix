{ config, pkgs, lib, ... }:
{
  # Add VLC and Wayland libraries to system packages
  environment.systemPackages = with pkgs; [
    # Regular VLC
    vlc

    # Qt Wayland integration libraries
    libsForQt5.qtwayland
  ];

  # Set environment variables for better VLC Wayland integration
  environment.sessionVariables = {
    # Force VLC to use Wayland
    QT_QPA_PLATFORM = "wayland";

    # Enable hardware acceleration
    VLC_GPU_DECODE = "1";

    # Force the Wayland interface
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };
}
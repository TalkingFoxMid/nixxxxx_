{ config, pkgs, lib, ... }:
{
  # Add MPV and useful plugins to system packages
  environment.systemPackages = with pkgs; [
    # MPV player
    mpv

    # FFmpeg for better codec support
    ffmpeg
    
    # Additional utilities
    mpvScripts.mpris  # MPRIS support for integrating with desktop environment
    yt-dlp            # For streaming videos from websites
  ];

  # Set environment variables for better MPV Wayland integration
  environment.sessionVariables = {
    # Environment variables for MPV
    MPV_HWDEC = "auto-safe";  # Enable hardware acceleration
    MPV_PROFILE = "gpu-hq";   # Use high quality GPU rendering
  };
}

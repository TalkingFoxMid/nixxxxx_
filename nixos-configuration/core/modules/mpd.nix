{ config, pkgs, lib, ... }:
{
  # Enable MPD service
  services.mpd = {
    enable = true;
    user = "talkingfoxmid";
    group = "users";
    
    # Configure MPD to use the WebDAV mount as music directory
    musicDirectory = "/mnt/webdav/music";
    
    # Set up database and playlists in user's home directory
    dataDir = "/home/talkingfoxmid/.mpd";
    
    # Enable network listening (for remote control apps)
    network.listenAddress = "127.0.0.1";
    network.port = 6600;
    
    # Add audio outputs
    extraConfig = ''
      # PulseAudio output
      audio_output {
        type "pulse"
        name "Pipewire Playback"
      }
      
      # HTTP stream output (optional)
      audio_output {
        type "httpd"
        name "HTTP Stream"
        encoder "vorbis"
        port "8000"
        bitrate "192"
        format "44100:16:2"
        always_on "no"
        tags "yes"
      }

      # Visualizer output for ncmpcpp
      audio_output {
        type "fifo"
        name "Visualizer"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };
  
  systemd.services.mpd.serviceConfig.RequiresMountsFor = ["/mnt/webdav"];
}
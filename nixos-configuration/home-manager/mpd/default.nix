{users, config, pkgs, ...}:
{
  # Add MPD and related tools
  home.packages = with pkgs; [
    mpc_cli
    ncmpcpp
    ncmpc
  ];

  # Configure MPD as a user service
  services.mpd = {
    enable = true;
    
    # Configure MPD to use the WebDAV mount as music directory
    musicDirectory = "/mnt/webdav/music";
    
    # Set up database and playlists in user's home directory
    dataDir = "/home/talkingfoxmid/.mpd";
    
    # Enable network listening (for remote control apps)
    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
    };
    
    # Add audio outputs
    extraConfig = ''
      # PulseAudio output
      audio_output {
        type     "pipewire"
        name     "PipeWire Sound Server"
        enabled  "yes"
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
  

  # Configure ncmpcpp client
  programs.ncmpcpp = {
    enable = true;
    settings = {
      # Basic settings
      mpd_host = "localhost";
      mpd_port = 6600;
      mpd_connection_timeout = 5;
      mpd_music_dir = "/mnt/webdav/music";
      
      # Visual settings
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "Visualizer";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";
      visualizer_look = "●▮";
      
      # Display settings
      song_list_format = "{%a - }{%t}|{$8%f$9}$R{$3(%l)$9}";
      song_status_format = "{{%a{ \"%b\"{ (%y)}} - }{%t}}|{%f}";
      song_library_format = "{%n - }{%t}|{%f}";
      alternative_header_first_line_format = "$b$1$aqqu$/a$9 {%t}|{%f} $1$atqq$/a$9$/b";
      alternative_header_second_line_format = "{{$4$b%a$/b$9}{ - $7%b$9}{ ($4%y$9)}}|{%D}";
      
      # Behavior settings
      playlist_disable_highlight_delay = 5;
      message_delay_time = 5;
      autocenter_mode = "yes";
      centered_cursor = "yes";
    };
  };

}

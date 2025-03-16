{users, config, pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    settings = {
      remember_window_size = "no";
      initial_window_width = "120c";
      initial_window_height = "30c";
      window_padding_width = "0";
      background_opacity = "0.75";
      font_size = "14.0";
      foreground = "#c5c8c6";
      background = "#1d1f21";
    };
  };
}

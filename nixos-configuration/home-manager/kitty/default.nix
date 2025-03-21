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

      # Gruvbox Dark color scheme for kitty
      foreground = "#ebdbb2";
      background = "#282828";

      # Black
      color0 = "#282828";
      color8 = "#928374";

      # Red
      color1 = "#cc241d";
      color9 = "#fb4934";

      # Green
      color2 = "#98971a";
      color10 = "#b8bb26";

      # Yellow
      color3 = "#d79921";
      color11 = "#fabd2f";

      # Blue
      color4 = "#458588";
      color12 = "#83a598";

      # Magenta
      color5 = "#b16286";
      color13 = "#d3869b";

      # Cyan
      color6 = "#689d6a";
      color14 = "#8ec07c";

      # White
      color7 = "#a89984";
      color15 = "#ebdbb2";

      # Cursor color
      cursor = "#ebdbb2";
      cursor_text_color = "#282828";
    };
  };
}

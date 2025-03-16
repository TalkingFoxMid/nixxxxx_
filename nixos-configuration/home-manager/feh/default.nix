{users, config, pkgs, ...}:
{
  programs.feh = {
    enable = true;
    buttons = {
      zoom_in = 4;
      zoom_out = 5;
    };
    keybindings = {
      "C-0" = "zoom_default";
    };
  };
}

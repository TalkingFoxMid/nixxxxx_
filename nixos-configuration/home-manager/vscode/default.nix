{users, config, pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    userSettings = { 
      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 2;  # This equals 200% zoom
    };
  };
}


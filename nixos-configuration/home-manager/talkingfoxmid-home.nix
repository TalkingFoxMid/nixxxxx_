{ users, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./timg
    ./kitty
    ./fuzzel
    ./git
    ./neovim
    ./hypr
    ./zsh
    ./mpd
    ./anki
    ./claude-code
    ./eww
  ];

  home.username = "talkingfoxmid";
  home.homeDirectory = "/home/talkingfoxmid";

  # Add scripts to PATH for both Hyprland and Fuzzel
  home.sessionPath = [ "/home/talkingfoxmid/nix-state/scripts/" ];
  home.sessionVariables.PATH = "$PATH:/home/talkingfoxmid/nix-state/scripts/";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    zoxide
    neofetch
    btop
    hyprpaper
    jq
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    material-icons
  ];

  home.file = {

  };


  home.sessionVariables = {
    NIX_PATH=
    ''
    $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:$NIX_PATH}
    '';
    PICULO = "123";
  };
  
  # Add fcitx5 configuration with larger font size
  home.file.".config/fcitx5/conf/classicui.conf".text = ''
    # Vertical Candidate List
    Vertical Candidate List=False
    # Font for Chinese text in candidate window
    Font="Noto Sans CJK SC 24"
  '';

  programs.home-manager.enable = true;


  programs.neovim = {
    enable = true;
    extraConfig = 
    ''
    set shiftwidth=2
    '';
  };

  programs.vscode = {
    enable = true;
    userSettings = { "window.titleBarStyle" = "custom"; };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [];
  };
}

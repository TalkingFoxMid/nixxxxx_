{ users, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./feh
    ./kitty
    ./fuzzel
    ./git
    ./neovim
    ./hypr
  ];

  home.username = "talkingfoxmid";
  home.homeDirectory = "/home/talkingfoxmid";

  # Add scripts to PATH for both Hyprland and Fuzzel
  home.sessionPath = [ "/home/talkingfoxmid/nix-state/scripts/" ];
  home.sessionVariables.PATH = "$PATH:/home/talkingfoxmid/nix-state/scripts/";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    starfetch
    btop
    hyprpaper
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

  programs.home-manager.enable = true;


  programs.neovim = {
    enable = true;
    extraConfig = 
    ''
    set shiftwidth=2
    '';
  };

  programs.zsh = {
  enable = true;
  initExtra = "starfetch";
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  };
  programs.vscode = {
    enable = true;
    userSettings = { "window.titleBarStyle" = "custom"; };
  };
}

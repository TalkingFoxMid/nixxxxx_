{ users, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # GUI version
    todoist-electron

    # CLI version
    todoist
  ];
}
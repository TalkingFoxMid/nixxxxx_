{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    extraConfig =
    ''
    set shiftwidth=2
    '';
  };
}
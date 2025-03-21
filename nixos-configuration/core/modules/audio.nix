{ config, pkgs, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];
}

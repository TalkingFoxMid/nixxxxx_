{ config, pkgs, lib, ... }:
{
  users.users.talkingfoxmid = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "talkingfoxmid";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "adbusers" ];
    packages = with pkgs; [];
  };
}
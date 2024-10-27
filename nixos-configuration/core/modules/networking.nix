{ config, pkgs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

   # Define your hostname.
  networking.hostName = "nixos";

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

}
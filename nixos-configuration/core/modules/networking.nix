{ config, pkgs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

   # Define your hostname.
  networking.hostName = "nixos";

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # Enable NetworkManager VPN plugins including OpenVPN
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # Add NetworkManager OpenVPN plugin to environment packages
  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
  ];

  networking.firewall.allowedTCPPorts = [ 16666 8188 ];


}

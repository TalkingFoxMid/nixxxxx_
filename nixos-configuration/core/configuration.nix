# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ../machine/hardware-configuration.nix
      ./modules/display-manager.nix
      ./modules/bluetooth.nix
      ./modules/wm.nix
      ./modules/polkit.nix
      ./modules/virtualisation.nix
      ./modules/networking.nix
      ./modules/users.nix
      ./modules/audio.nix
      ./modules/nvidia.nix
      ./modules/locale.nix
      ./modules/boot.nix
      ./modules/time.nix
      ./modules/flatpak.nix
      
    ];


  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.adb.enable = true;


  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";


  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
	programs.gnupg.agent = {                                                      
	  enable = true;
	  enableSSHSupport = true;
	};
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = ["libexec"];


  environment.systemPackages = with pkgs; [
    polkit-kde-agent
    wl-clipboard
    bind
    patchelf
    transmission_4-gtk
    gnupg
    pkgs.jdk
    picom
    egl-wayland
  ];

  system.stateVersion = "23.05";
}



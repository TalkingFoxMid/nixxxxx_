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
      ./modules/pipewire.nix
      ./modules/lutris.nix
      ./modules/obsidian.nix
      ./modules/kubernetes.nix
      ./modules/sws.nix
      ./modules/gc.nix

    ];


  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Mount point for nvme1n1p4 drive
  fileSystems."/mnt/nn" = {
    device = "/dev/nvme1n1p4";
    fsType = "ext4";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
	programs.gnupg.agent = {                                                      
	  enable = true;
	  enableSSHSupport = true;
	};
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = ["libexec"];

programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    openvpn
    wl-clipboard
    bind
    grimblast
    patchelf
    transmission_4-gtk
    gnupg
    picom
    egl-wayland
    distrobox
    openvpn
    slurp
    postman
    pass
    grim
    vlc
    python3
    python3Packages.pip
    xdg-utils
    dbus
    ranger
    htop
    p7zip

  ];

  system.stateVersion = "24.05";

}



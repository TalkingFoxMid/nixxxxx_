# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ../machine/hardware-configuration.nix
      ./display-manager.nix
      ./bluetooth.nix
      ./wm.nix
      ./polkit.nix
      ./virtualisation.nix
      ./networking.nix
      ./users.nix
      ./audio.nix
      ./nvidia.nix
    ];


  nixpkgs.overlays = [
    (final: prev: {
      obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
    })
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.activationScripts.ldso = lib.stringAfter [ "usrbinenv" ] ''
            mkdir -m 0755 -p /lib64
            ln -sfn ${pkgs.glibc.out}/lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2.tmp
            mv -f /lib64/ld-linux-x86-64.so.2.tmp /lib64/ld-linux-x86-64.so.2 # atomically replace
          '';
  # Android 
  programs.adb.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  nixpkgs.config.permittedInsecurePackages = ["electron-24.8.6"];

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
    obsidian-wayland
    patchelf
    transmission_4-gtk
    gnupg
    pkgs.jdk
    picom
    egl-wayland
  ];

  services.flatpak.enable = true;
  system.stateVersion = "23.05";
}



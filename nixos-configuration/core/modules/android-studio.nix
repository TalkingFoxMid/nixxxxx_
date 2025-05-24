{ config, pkgs, lib, ... }:
{
  # Enable KVM for Android emulators
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  # Add user to required groups for Android development
  users.users.talkingfoxmid = {
    extraGroups = [ "kvm" "libvirtd" "plugdev" ];
  };

  # Enable udev rules for Android devices
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  # Android development environment
  programs.adb.enable = true;

  # System packages for Android development
  environment.systemPackages = with pkgs; [
    # Android Studio and SDK
    android-studio
    android-tools
    
    # Additional development tools
    gradle
    maven
    openjdk17
    
    # Emulator dependencies
    libGL
    libpulseaudio
    libxkbcommon
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libxcb
    
    # For better emulator performance
    qemu
    bridge-utils
    virt-manager # GUI for managing VMs if needed
  ];

  # Environment variables for Android development
  environment.sessionVariables = {
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    ANDROID_AVD_HOME = "$HOME/.android/avd";
    JAVA_HOME = "${pkgs.openjdk17.home}";
    # Enable hardware acceleration for emulator
    ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1";
  };

  # Kernel modules needed for KVM
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  
  # Additional kernel parameters for better emulator performance
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  # Enable hardware acceleration support
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}

{users, config, pkgs, ...}:
{
  # Android Studio configuration files
  home.file = {
    # Android Studio settings for better performance
    ".android/advancedFeatures.ini".text = ''
      Vulkan = on
      GLDirectMem = on
      GLAsyncSwap = on
      GLDMA = on
      HVF = on
      KVM = on
      Hypervisor = on
      WindowsHypervisorPlatform = on
      VirtioInput = on
      MultiDisplay = on
      WiFi = on
      VulkanNullOptionalStrings = on
      YUV420888toNV21 = on
      YUVCache = on
    '';

    # AVD config for better performance
    ".android/avd/.ini".text = ''
      avd.ini.encoding=UTF-8
      hw.gpu.enabled=yes
      hw.gpu.mode=host
      hw.ramSize=4096
      runtime.network.latency=none
      runtime.network.speed=full
      skin.dynamic=yes
      vm.heapSize=256
    '';
  };

  # Add Android development tools to user packages
  home.packages = with pkgs; [
    # Additional development utilities
    scrcpy  # Screen mirroring for Android devices
    android-file-transfer  # File transfer tool
  ];
}

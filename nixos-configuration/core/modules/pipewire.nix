{config, pkgs, lib, ...}:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
  }; 
  
  # Add essential audio utilities
  environment.systemPackages = with pkgs; [
    pavucontrol      # PulseAudio volume control
    easyeffects      # Audio effects for PipeWire
  ];
}

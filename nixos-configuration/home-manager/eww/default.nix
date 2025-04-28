{users, config, pkgs, ...}:
{
  programs.eww = {
    enable = true;
    configDir = ./config;
  };
  
  # Add lm_sensors for CPU temperature monitoring
  home.packages = with pkgs; [
    lm_sensors  # For CPU temperature monitoring
    pciutils    # Helps with hardware identification
    font-awesome # For icons in the bar
  ];

}

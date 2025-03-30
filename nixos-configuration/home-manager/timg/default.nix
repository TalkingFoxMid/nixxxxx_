{users, config, pkgs, ...}:
{
  home.packages = with pkgs; [
    timg
  ];
  
  # Configuration through environment variables if needed
  home.sessionVariables = {
    enable = true;
  };
}

{users, config, pkgs, ...}:
{
  home.packages = with pkgs; [
    timg
  ];

}

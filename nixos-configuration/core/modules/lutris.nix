{config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    lutris-free
  ];
}

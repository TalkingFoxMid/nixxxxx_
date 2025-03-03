{ config, pkgs, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    static-web-server
  ];

  services.static-web-server = {
    enable = true;
    root = "/home/talkingfoxmid/http";
  };
}

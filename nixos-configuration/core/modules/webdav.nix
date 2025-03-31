{ config, pkgs, lib, ... }:
{
  # Install the davfs2 package
  environment.systemPackages = with pkgs; [
    davfs2
  ];

  fileSystems."/mnt/webdav" = {
    device = "http://192.168.18.18/uploads";
    fsType = "davfs";
  };

  # Enable the davfs2 service
  services.davfs2.enable = true;

  # Path to SSH keys for agenix decryption
  age.identityPaths = [ "/etc/ssh/ssh_host_rsa_key" ];
  
  # Reference the agenix secret
  age.secrets.webdav = {
    file = "/home/talkingfoxmid/nix-state/secrets/webdav-credentials.age";
    path = "/etc/davfs2/secrets";
    mode = "0600";
  };
}
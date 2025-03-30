{ config, pkgs, lib, ... }:
{
  # Ensure path to SSH keys for agenix decryption
  age.identityPaths = [ "/etc/ssh/ssh_host_rsa_key" ];
  
  # OpenVPN configuration secret
  age.secrets.openvpn-config = {
    file = "/home/talkingfoxmid/nix-state/secrets/openvpn-config.age";
    path = "/home/talkingfoxmid/.openvpn/config.ovpn";
    owner = "talkingfoxmid";
    group = "users";
    mode = "0600";
  };

  # Ensure the OpenVPN directory exists
  system.activationScripts.openvpnDir = ''
    mkdir -p /home/talkingfoxmid/.openvpn
    chown talkingfoxmid:users /home/talkingfoxmid/.openvpn
  '';
}

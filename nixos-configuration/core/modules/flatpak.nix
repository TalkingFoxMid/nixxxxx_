{config, pkgs, lib, ...}:
{
  services.flatpak.enable = true;
  
  # Grant filesystem access to all Flatpak applications
  system.userActivationScripts.flatpak-filesystem-access = {
    text = ''
      # Set filesystem permissions for all installed Flatpak applications
      ${pkgs.flatpak}/bin/flatpak override --user --filesystem=home
    '';
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
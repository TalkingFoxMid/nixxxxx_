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
  
  # Create a service to clean up stale IntelliJ IDEA lock files on boot
  systemd.user.services.cleanup-idea-locks = {
    description = "Clean up stale IntelliJ IDEA lock files";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "cleanup-idea-locks" ''
        # Remove stale lock files for IntelliJ IDEA
        rm -f $HOME/.var/app/com.jetbrains.IntelliJ-IDEA-Community/config/JetBrains/IdeaIC*/.lock
      ''}";
      RemainAfterExit = false;
    };
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
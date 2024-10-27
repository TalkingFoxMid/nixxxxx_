{ config, pkgs, lib, ... }:
{
	security.polkit.enable = true;

  systemd = {
    user.services.polkit-kde-agent-1 = {
      enable = true;
      description = "polkit-kde-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
			    Type = "simple";
			    ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
			    Restart = "on-failure";
			    RestartSec = 1;
			    TimeoutStopSec = 10;
		  };
	  };
  };
}
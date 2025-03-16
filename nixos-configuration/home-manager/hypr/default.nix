{users, config, pkgs, ...}:

{
   wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          ",preferred,auto,auto"
          "HDMI-A-1, 1920x1080, 0x0, 1"
        ];

        exec-once = "hyprpaper & waybar";

        env = [
          "XCURSOR_SIZE,24"
        ];

        "$mainMod" = "SUPER";
        "$mainModShift" = "SUPER_SHIFT";

        input = {
          kb_layout = "us,ru";
          kb_variant = "";
          kb_model = "";
          kb_options = "grp:win_space_toggle";
          kb_rules = "";
          follow_mouse = 1;

          touchpad = {
            natural_scroll = false;
          };

          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures = {
          workspace_swipe = false;
        };

        misc = {
          force_default_wallpaper = -1;
        };

        bind = [
          # Application launchers
          "$mainMod, Return, exec, alacritty"
          "$mainModShift, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, dolphin"
          "$mainMod, F, exec, fuzzel"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, wofi --show drun"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          # Focus movement
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Workspace switching
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Special workspace
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        workspace = [
          "1, monitor:DP-2"
          "2, monitor:DP-2"
          "3, monitor:DP-2"
          "4, monitor:DP-2"
          "5, monitor:DP-2"
        ];
      };
    };
}
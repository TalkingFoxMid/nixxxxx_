{users, config, pkgs, ...}:

{
   wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];


      settings = {
        monitor = [
	  "DP-1, 3840x2160@239.99, 0x0, 1.50"
        ];
        xwayland = {
          force_zero_scaling = true;
        };

        exec-once = [
          "hyprpaper" 
          "eww daemon" 
          "eww open bar"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "PATH,$PATH:/home/talkingfoxmid/nix-state/scripts/"
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
          "col.active_border" = "rgba(d79921ee) rgba(b8bb26ee) 45deg";
          "col.inactive_border" = "rgba(928374aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1;
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

        # Define rules for the btop and nvtop windows to make them floating
        windowrulev2 = [
          # btop rules
          "float,class:^(kitty-btop)$"
          "size 1600 900,class:^(kitty-btop)$"
          "center,class:^(kitty-btop)$"
          "workspace special:btop,class:^(kitty-btop)$"
          
          # nvtop rules
          "float,class:^(kitty-nvtop)$"
          "size 1400 800,class:^(kitty-nvtop)$"
          "center,class:^(kitty-nvtop)$"
          # ncmpcpp rules
          "float,class:^(kitty-ncmpcpp)$"
          "size 1600 900,class:^(kitty-ncmpcpp)$"
          "center,class:^(kitty-ncmpcpp)$"
          "workspace special:nvtop,class:^(kitty-nvtop)$"

          # tfloat1 rules
          "float,class:^(kitty-tfloat1)$"
          "size 1400 800,class:^(kitty-tfloat1)$"
          "center,class:^(kitty-tfloat1)$"
          "workspace special:tfloat1,class:^(kitty-tfloat1)$"
          
          # Discord rules - assign to workspace 11
          "workspace 11,class:^(discord)$"
          "workspace 11,class:^(WebCord)$"
          # Add for any other Discord client variants you might use
          "workspace 11,title:^(Discord)$"
          "workspace 11,title:^(Discord Updater)$"

          # VLC rule for better handling
          "float,class:^(vlc)$,title:^(Extended Settings)$"
          
          # Add Zen Browser rules - assign to workspace 12
          "workspace 12,class:^(Zen)$"
        ];

        bind = [
          # Application launchers
          "$mainMod, Return, exec, kitty"
          "$mainModShift, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, dolphin" 
          "$mainMod, F, exec, fuzzel"
          ", F12, exec, bash -c 'if ! hyprctl clients | grep -q \"class: kitty-btop\"; then kitty --class kitty-btop -e btop; fi; hyprctl dispatch togglespecialworkspace btop'"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, wofi --show drun"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          # Discord shortcut - toggle workspace 11 and launch if not running
          "$mainMod, D, exec, bash -c 'hyprctl dispatch workspace 11; com.discordapp.Discord'"
          
          # Zen Browser shortcut - toggle workspace 12 and launch if not running
          "$mainMod, B, exec, bash -c 'hyprctl dispatch workspace 12; if ! flatpak ps | grep -q app.zen_browser.zen; then flatpak run app.zen_browser.zen; fi'"

          # Screenshot (using the screenshot script)
          "$mainMod, S, exec, screenshot"
          
          # Toggle nvtop overlay with F11 (with check for existing window)
          ", F11, exec, bash -c 'if ! hyprctl clients | grep -q \"class: kitty-nvtop\"; then kitty --class kitty-nvtop -e nvtop; fi; hyprctl dispatch togglespecialworkspace nvtop'"

          # Toggle ncmpcpp music player with F2 (with check for existing window)
          ", F2, exec, bash -c 'if ! hyprctl clients | grep -q \"class: kitty-ncmpcpp\"; then kitty --class kitty-ncmpcpp -e ncmpcpp; fi; hyprctl dispatch togglespecialworkspace ncmpcpp'"


          ", F1, exec, bash -c 'if ! hyprctl clients | grep -q \"class: kitty-tfloat1\"; then kitty --class kitty-tfloat1; fi; hyprctl dispatch togglespecialworkspace tfloat1'"


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
          "$mainMod SHIFT, D, movetoworkspace, 11"
          "$mainMod SHIFT, B, movetoworkspace, 12"

          # Special workspace
          "$mainMod, grave, togglespecialworkspace, magic"
          "$mainMod SHIFT, grave, movetoworkspace, special:magic"
          
          # Close monitoring windows
          "$mainMod, Escape, execr, hyprctl dispatch closewindow kitty-btop"
          "$mainMod SHIFT, Escape, execr, hyprctl dispatch closewindow kitty-nvtop"

          # Volume control using Fn keys
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        workspace = [
            "1, monitor:DP-1"
            "2, monitor:DP-1"
            "3, monitor:DP-1"
            "4, monitor:DP-1"
            "5, monitor:DP-1"
            "6, monitor:DP-1"
            "7, monitor:DP-1"
            "8, monitor:DP-1"
            "9, monitor:DP-1"
            "10, monitor:DP-2"
            "11, monitor:DP-1, discord"
            "12, monitor:DP-1, zen"
        ];
      };
    };
}

{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "wl-paste --type text --watch cliphist store" #Stores only text data
        "wl-paste --type image --watch cliphist store" #Stores only image data
        "wl-clip-persist --clipboard both" # persist both clipboard

        # polkit
        "systemctl --user start hyprpolkitagent"

        # notifications
        "dunst"

        # bar
        "waybar"
      ];

      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1"
        "DP-1,1920x1080@60,1920x0,1"
        ",preferred,auto,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "compose:rwin";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "slideIn, 0, 0, 0, 1"
          "slideOut, 0, 1, 0, 1"
        ];

        animation = [
          "windowsIn, 1, 1, default, slide"
          "windowsOut, 1, 1, default, slide"
          "windowsMove, 1, 5, default, slide"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 5, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      windowrule = [
        # rofi settings
        "float,class:^(rofi)$"
        "noanim,class:^(rofi)$"
        "noborder,class:^(rofi)$"
        "focusonactivate,class:^(rofi)$"
        "pin,class:^(rofi)$"
        "rounding,class:^(rofi)$"

        # disable animations on hyprpicker
        "noanim,class:^(hyprpicker)$"
        "noanim,class:^(slurp)$"

        # wine fix
        "nomaxsize,class:.*\\.exe$"

        # flameshot fixes
        "noanim,class:^(flameshot)$"
        "float,class:^(flameshot)$"
        "move 0 0,class:^(flameshot)$"
        "pin,class:^(flameshot)$"
        "fullscreenstate 3 0,class:^(flameshot)$"
        "monitor 0,class:^(flameshot)$"
        # no anims on flameshot
        "noanim,class:^(flameshot)$"
        "noborder,class:^(flameshot)$"

        # chromium fixes
        "noblur,class:^(chromium)$"
      ];

      layerrule = [
        "noanim, notifications"
      ];

      bind =
        [
          "$mod, return, exec, ghostty"
          "$mod, C, killactive,"
          "$mod, R, exec, rofi -show drun"
          "$mod CTRL, M, exec, hyprctl dispatch exit"

          "$mod, V, togglefloating,"
          "$mod, P, pseudo,"
          "$mod, J, togglesplit,"
          "$mod, F, fullscreen,"

          "$mod, R, exec, rofi -show drun"
          "$mod SHIFT, P, exec, hyprpicker -r | wl-copy"
          ", Print, exec, grimblast copy area --freeze"
          "$mod, Print, exec, grimblast copy output --freeze"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}

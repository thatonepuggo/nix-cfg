{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myHome;
  # thank you https://discourse.nixos.org/t/list-to-attribute-set/20929/4
  lak = field: list:
    builtins.listToAttrs (map (v: {
        name = v.${field};
        value = v;
      })
      list);
in {
  config = lib.mkIf (cfg.windowManager == "niri") {
    xdg.portal = {
      xdgOpenUsePortal = true;
      enable = true;
      config.common = {
        default = ["gtk" "gnome"];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    programs.niri = {
      settings = {
        spawn-at-startup = let
          toSpawn = [
            # xwayland
            "${pkgs.xwayland-satellite}/bin/xwayland-satellite"

            # background
            "${pkgs.swww}/bin/swww-daemon & sleep 0.1 && ${pkgs.swww}/bin/swww img ${cfg.wallpaper}"

            # notifications
            "dunst"

            # bar
            "waybar"
          ];
        in
          builtins.map (cmd: {command = ["sh" "-c" cmd];}) toSpawn;

        input.keyboard.xkb = {
          layout = "us";
          options = "compose:rwin";
        };

        outputs = lak "name" cfg.monitors;

        environment = {
          DISPLAY = ":0";
        };

        window-rules = [
          {
            matches = [
              {
                app-id = "steam";
                title = "^notificationtoasts_\\d+_desktop$";
              }
            ];
            default-floating-position = {
              x = 0;
              y = 0;
              relative-to = "bottom-right";
            };
            border.enable = false;
            open-focused = false;
          }
        ];

        gestures.hot-corners.enable = false;

        prefer-no-csd = true;

        screenshot-path = "~/Pictures/Screenshots/Screenshot %Y-%m-%d %H-%M-%S.png";

        binds = with config.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          # Suggested binds for running programs: terminal, app launcher, screen locker.
          "Mod+Return".action = spawn "ghostty";
          "Mod+D".action = spawn ["rofi" "-show" "drun"];
          "Super+Alt+L".action = spawn "swaylock";

          # Example volume keys mappings for PipeWire & WirePlumber.
          "XF86AudioRaiseVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
          "XF86AudioLowerVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];

          "Mod+Q".action = close-window;

          "Mod+O".action = toggle-overview;
          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;

          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;

          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;

          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;

          # You can refer to workspaces by index. However, keep in mind that
          # niri is a dynamic workspace system, so these commands are kind of
          # "best effort". Trying to refer to a workspace index bigger than
          # the current workspace count will instead refer to the bottommost
          # (empty) workspace.
          #
          # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
          # will all refer to the 3rd workspace.
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Ctrl+1".action = {move-column-to-workspace = 1;};
          "Mod+Ctrl+2".action = {move-column-to-workspace = 2;};
          "Mod+Ctrl+3".action = {move-column-to-workspace = 3;};
          "Mod+Ctrl+4".action = {move-column-to-workspace = 4;};
          "Mod+Ctrl+5".action = {move-column-to-workspace = 5;};
          "Mod+Ctrl+6".action = {move-column-to-workspace = 6;};
          "Mod+Ctrl+7".action = {move-column-to-workspace = 7;};
          "Mod+Ctrl+8".action = {move-column-to-workspace = 8;};
          "Mod+Ctrl+9".action = {move-column-to-workspace = 9;};

          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          "Mod+R".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;

          # Finer width adjustments.
          # This command can also:
          # * set width in pixels: "1000"
          # * adjust width in pixels: "-5" or "+5"
          # * set width as a percentage of screen width: "25%"
          # * adjust width as a percentage of screen width: "-10%" or "+10%"
          # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
          # set-column-width "100" will make the column occupy 200 physical screen pixels.
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";

          # Finer height adjustments when in column with other windows.
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          # Actions to switch layouts.
          # Note: if you uncomment these, make sure you do NOT have
          # a matching layout switch hotkey configured in xkb options above.
          # Having both at once on the same hotkey will break the switching,
          # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
          # "Mod+Space".action = switch-layout "next";
          # "Mod+Shift+Space".action = switch-layout "prev";

          "Print".action = screenshot;
          "Ctrl+Print".action = {screenshot-screen = [];};
          "Alt+Print".action = screenshot-window;

          # The quit action will show a confirmation dialog to avoid accidental exits.
          # If you want to skip the confirmation dialog, set the flag like so:
          # "Mod+Shift+E".action = quit { skip-confirmation=true; };
          "Mod+Shift+E".action = quit;

          "Mod+Shift+P".action = power-off-monitors;
        };
      };
    };
  };
}

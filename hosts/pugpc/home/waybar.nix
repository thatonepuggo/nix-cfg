{
  config,
  pkgs,
  ...
}: let
  cfg = config.myHome;
in {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar at the bottom of your screen
        height = 24; # Waybar height
        # Choose the order of the modules
        modules-left = ["${cfg.windowManager}/workspaces" "${cfg.windowManager}/mode"];
        modules-center = ["${cfg.windowManager}/window"];
        modules-right = ["keyboard-state" "wireplumber" "network" "cpu" "memory" "battery" "tray" "clock"];
        "${cfg.windowManager}/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
        };
        "${cfg.windowManager}/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "tray" = {
          # icon-size = 21;
          spacing = 1;
        };
        "clock" = {
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:L}";
        };
        "cpu" = {
          format = "{usage}% ";
        };
        "memory" = {
          format = "{}% ";
        };
        "battery" = {
          bat = "BAT0";
          states = {
            # good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = ["" "" "" "" ""];
        };
        "network" = {
          # interface = "wlp2s0"; # (Optional) To force the use of this interface
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
        };
        "wireplumber" = {
          # scroll-step = 1;
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "pavucontrol";
        };
        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "Sans Serif";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: white;
      }

      #window {
          font-weight: bold;
          font-family: "Sans Serif";
      }
      /*
      #workspaces {
          padding: 0 5px;
      }
      */

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #c9545d;
          border-top: 2px solid #c9545d;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #keyboard-state,
      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #custom-spotify,
      #tray,
      #mode {
          padding: 0 3px;
          margin: 0 2px;
      }

      #clock {
          font-weight: bold;
      }

      #battery {
      }

      #battery icon {
          color: red;
      }

      #battery.charging {
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #keyboard-state > label:not(:last-child) {
        padding: 0 5px;
      }

      #cpu {
      }

      #memory {
      }

      #network {
      }

      #network.disconnected {
          background: #f53c3c;
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
      }

      #custom-spotify {
          color: rgb(102, 220, 105);
      }

      #tray {
      }
    '';
  };
}

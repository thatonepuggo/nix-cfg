{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  cfg = config.myHome.defaultApps;
in {
  options = let
    inherit (lib.types) attrs;
  in {
    myHome.defaultApps = {
      enable = mkEnableOption "default apps";
      extraDefaultApps = mkOption {
        description = "extra xdg.mimeApps.defaultApplications declarations";
        type = attrs;
        default = {};
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications =
      {
        "application/pdf" = ["chromium.desktop"];
        "image/*" = ["gwenview.desktop"];
        "video/png" = ["mpv.desktop"];
        "video/jpg" = ["mpv.desktop"];
        "video/*" = ["mpv.desktop"];
      }
      // cfg.extraDefaultApps;
  };
}

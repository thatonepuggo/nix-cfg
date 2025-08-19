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
    xdg.mimeApps = {
      enable = true;
      defaultApplications =
        {
          "inode/directory" = ["org.gnome.Nautilus.desktop"];

          "application/pdf" = ["floorp.desktop"];

          "text/html" = ["floorp.desktop"];
          "text/*" = ["nvim.desktop"];

          "image/*" = ["org.gnome.eog.desktop"];

          "video/png" = ["mpv.desktop"];
          "video/jpg" = ["mpv.desktop"];
          "video/*" = ["mpv.desktop"];
        }
        // cfg.extraDefaultApps;
    };
  };
}

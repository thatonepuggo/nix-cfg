{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.myHome.vinegar;
  inherit (lib) mkEnableOption mkOption mkIf;
in {
  options.myHome.vinegar = {
    enable = mkEnableOption "vinegar";
  };

  config.programs.vinegar = mkIf cfg.enable {
    enable = true;
    settings = {
      studio = {
        # https://github.com/vinegarhq/vinegar/issues/591
        forced_version = "version-c98e1b5b4dd94b96";

        # doesnt work i guess
        webview = "";

        # fix flickering
        dxvk = false;
        renderer = "Vulkan";
      };
    };
  };
}

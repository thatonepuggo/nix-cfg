{ pkgs, lib, config, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  cfg = config.myNixOS.swaylock;
in {
  options.myNixOS.swaylock = {
    enable = mkEnableOption "swaylock";
  };

  config = mkIf (cfg.enable) {
    security.pam.services.swaylock = {};
    home-manager.sharedModules = [
      {
        programs.swaylock = {
          enable = true;
          package = pkgs.swaylock-effects;
          settings = {
            screenshots = true;
            clock = true;
            effect-blur = "7x5";
          };
        };
      }
    ];
  };
}

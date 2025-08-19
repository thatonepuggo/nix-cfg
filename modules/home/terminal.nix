{ pkgs, config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  cfg = config.myHome.terminal;
in {
  options.myHome.terminal = {
    enable = mkEnableOption "terminal";
  };

  config = mkIf (cfg.enable) {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "monospace";
      };
    };
  };
}

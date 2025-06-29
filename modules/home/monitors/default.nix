{ lib, config, ... }: let 
  inherit (lib) types;
  monitor = types.submodule {
    options = {
      name = lib.mkOption {
        description = "identifier of the monitor";
        type = types.str;
        example = "HDMI-A-1";
      };
      mode = {
        width = lib.mkOption {
          description = "width of the monitor";
          type = types.ints.positive;
          example = 1920;
        };
        height = lib.mkOption {
          description = "height of the monitor";
          type = types.ints.positive;
          example = 1080;
        };
        refresh = lib.mkOption {
          description = "refresh rate of the monitor";
          type = types.float;
          example = 60.;
        };
      };
      position = {
        x = lib.mkOption {
          description = "x position of the monitor";
          type = types.int;
          example = 0;
        };
        y = lib.mkOption {
          description = "y position of the monitor";
          type = types.int;
          example = 0;
        };
      };
      scale = lib.mkOption {
        description = "scale of the monitor";
        type = types.float;
        default = 1.;
        example = 2.;
      };
    };
  };
in {
  options = {
    myHome = {
      monitors = lib.mkOption {
        description = "a list of monitors and their properties";
        type = types.listOf monitor;
        default = [];
      };
    };
  };
}

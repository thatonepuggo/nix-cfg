{ lib, config, ... }: {
  imports = [
    ./niri.nix
    ./hyprland.nix
  ];

  options = {
    myHome = {
      windowManager = lib.mkOption {
        description = "which window manager to enable.";
        type = lib.types.enum [
          "hyprland"
          "niri"
        ];
        example = "niri";
        default = "niri";
      };
    };
  };
}

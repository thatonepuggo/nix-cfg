{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    myHome.wallpaper = lib.mkOption {
      type = with lib.types; oneOf [str path package];
    };
  };
}

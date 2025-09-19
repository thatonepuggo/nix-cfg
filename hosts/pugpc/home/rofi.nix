{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
    ];
  };
}

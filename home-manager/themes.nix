{
  inputs,
  config,
  pkgs,
  stylix,
  ...
}: let
  cursor = {
    pkg = pkgs.rose-pine-hyprcursor;
    name = "BreezX-RosePine-Linux";
    size = 24;
  };
in {
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = [
    # extra fonts #
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans

    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.liberation

    # ms fonts
    pkgs.corefonts
    pkgs.vistafonts
  ];

  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      package = cursor.pkg;
      name = cursor.name; 
      size = cursor.size;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.ubuntu;
        name = "Ubuntu Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.ubuntu-mono;
        name = "UbuntuMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  home.sessionVariables = {
    HYPRCURSOR_NAME = cursor.name;
    HYPRCURSOR_SIZE = cursor.size;
    XCURSOR_NAME = cursor.name;
    XCURSOR_SIZE = cursor.size;
  };
}

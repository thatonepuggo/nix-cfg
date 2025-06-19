{
  inputs,
  pkgs,
  ...
}: let
  cursorPkg = pkgs.buildEnv {
    name = "combined-cursors";
    paths = [pkgs.rose-pine-cursor pkgs.rose-pine-hyprcursor];

    postBuild = ''
      mkdir $out/share/icons/RosePineCursor/

      # copy hyprcursors
      cp -r $out/share/icons/rose-pine-hyprcursor/hyprcursors/ $out/share/icons/RosePineCursor/
      cp -r $out/share/icons/rose-pine-hyprcursor/hyprcursors_uncompressed/ $out/share/icons/RosePineCursor/
      cp $out/share/icons/rose-pine-hyprcursor/manifest.hl $out/share/icons/RosePineCursor/

      # copy xcursors
      cp -r $out/share/icons/BreezeX-RosePine-Linux/cursors/ $out/share/icons/RosePineCursor
      cp $out/share/icons/BreezeX-RosePine-Linux/cursor.theme $out/share/icons/RosePineCursor
      cp $out/share/icons/BreezeX-RosePine-Linux/index.theme $out/share/icons/RosePineCursor

      # unlink
      unlink $out/share/icons/BreezeX-RosePine-Linux
      unlink $out/share/icons/BreezeX-RosePineDawn-Linux
      unlink $out/share/icons/rose-pine-hyprcursor
    '';
  };
  cursor = {
    pkg = cursorPkg;
    name = "RosePineCursor";
    size = 24;
  };
in {
  imports = [inputs.stylix.homeModules.stylix];

  home.pointerCursor = {
    name = cursor.name;
    package = cursor.pkg;
    size = cursor.size;

    gtk.enable = true;
    x11.enable = true;
  };

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

    targets.floorp.profileNames = ["user"];

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
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

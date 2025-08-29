{
  inputs,
  pkgs,
  config,
  ...
}: {
  fonts.packages = [
    # extra fonts #
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji

    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.liberation
    pkgs.nerd-fonts.noto

    # ms fonts
    pkgs.corefonts
    pkgs.vistafonts
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    image = with config.lib.stylix.colors.withHashtag;
      pkgs.runCommand "cat.png" {} ''
        pastel=${pkgs.pastel}/bin/pastel
        SHADOWS=$($pastel darken 0.1 '${base05}' | $pastel format hex)
        TAIL=$($pastel lighten 0.1 '${base02}' | $pastel format hex)
        HIGHLIGHTS=$($pastel lighten 0.1 '${base05}' | $pastel format hex)

        ${pkgs.imagemagick}/bin/convert ${./attachments/basecat.png} \
          -fill '${base00}' -opaque black \
          -fill '${base05}' -opaque white \
          -fill '${base08}' -opaque blue \
          -fill $SHADOWS -opaque gray \
          -fill '${base02}' -opaque orange \
          -fill $TAIL -opaque green \
          -fill $HIGHLIGHTS -opaque brown \
          $out'';

    cursor = {
      package = pkgs.yaru-theme;
      name = "Yaru";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.adwaita-icon-theme;
      light = "Adwaita";
      dark = "Adwaita";
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.noto;
        name = "NotoSerif Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.noto;
        name = "NotoSans Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
      };
    };

    targets.chromium.enable = true;
    targets.grub.enable = true;
  };
}

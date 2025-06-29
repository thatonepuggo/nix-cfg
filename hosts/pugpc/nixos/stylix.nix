{
  inputs,
  pkgs,
  config,
  ...
}: {
  config = {
    environment.systemPackages = [
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

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursor = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
      };

      targets.chromium.enable = true;
      targets.grub.enable = true;
      targets.plymouth.enable = true;

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
    };
  };
}

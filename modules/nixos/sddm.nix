{ pkgs, config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.myNixOS.sddm;

  custom-sddm-theme = pkgs.sddm-astronaut.override {
    themeConfig = with config.lib.stylix.colors.withHashtag; {
      Font = config.stylix.fonts.sansSerif.name;
      FontSize = "12";

      RoundCorners = "20";

      BackgroundPlaceholder = "${config.stylix.image}";
      Background = "${config.stylix.image}";
      BackgroundSpeed = "1.0";
      PauseBackground = "";
      CropBackground = "false";
      BackgroundHorizontalAlignment = "center";
      BackgroundVerticalAlignment = "center";
      DimBackground = "0.0";
      HeaderTextColor = "${base05}";
      DateTextColor = "${base05}";
      TimeTextColor = "${base05}";

      FormBackgroundColor = "${base03}";
      BackgroundColor = "${base02}";
      DimBackgroundColor = "${base01}";

      LoginFieldBackgroundColor = "${base02}";
      LoginFieldTextColor = "${base05}";
      PasswordFieldBackgroundColor = "${base02}";
      PasswordFieldTextColor = "${base05}";
      UserIconColor = "${base0E}";
      PasswordIconColor = "${base0E}";

      PlaceholderTextColor = "${base04}";
      WarningColor = "${base08}";

      LoginButtonBackgroundColor = "${base05}";
      LoginButtonTextColor = "${base0E}";
      SystemButtonsIconsColor = "${base0E}";
      SessionButtonTextColor = "${base0E}";
      VirtualKeyboardButtonTextColor = "${base0E}";

      DropdownTextColor = "${base05}";
      DropdownSelectedBackgroundColor = "${base03}";
      DropdownBackgroundColor = "${base02}";

      HighlightTextColor = "${base02}";
      HighlightBackgroundColor = "${base05}";
      HighlightBorderColor = "${base05}";

      HoverUserIconColor = "${base0D}";
      HoverPasswordIconColor = "${base0D}";
      HoverSystemButtonsIconsColor = "${base0D}";
      HoverSessionButtonTextColor = "${base0D}";
      HoverVirtualKeyboardButtonTextColor = "${base0D}";

      FullBlur = "true";
      BlurMax = "64";
      Blur = "1.0";

      HaveFormBackground = "false";
      FormPosition = "center";
    };
  };
in {
  options.myNixOS.sddm = {
    enable = mkEnableOption "my sddm configuration";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          CursorTheme = config.stylix.cursor.name;
          CursorSize = config.stylix.cursor.size;
        };
      };
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
        kdePackages.qtmultimedia
        custom-sddm-theme
      ];
    };

    environment.systemPackages = [
      custom-sddm-theme
    ];
  };
}

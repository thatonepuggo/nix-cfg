username: hostName: {
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./browser.nix
    ./dunst.nix
    ./eww
    ./ghostty.nix
    ./git.nix
    ./obs.nix
    ./rofi.nix
    ./spicetify.nix
    ./waybar.nix
    ./zsh.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      # fun
      fortune
      cowsay
      blahaj
      lolcat
      figlet

      # tools
      cloc
      ffmpeg
      imagemagick

      # gui
      pavucontrol
      vlc
      chatterino2
      (prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ffmpeg];

        # Change Java runtimes available to Prism Launcher
        jdks = [
          graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
      filezilla
      kdePackages.dolphin
      kdePackages.ark
      kdePackages.gwenview
      krita
      openutau
      audacity

      # langs
      lua
      gcc
      python3
      go

      # games
      doomrunner
      gzdoom
      luanti
    ];

    # do not edit
    stateVersion = "25.05";
  };

  programs.fastfetch.enable = true;
  programs.cava.enable = true;
  programs.btop.enable = true;
  programs.mpv.enable = true;
  programs.eza.enable = true;

  myHome = {
    windowManager = "niri";

    defaultApps = {
      enable = true;
      extraDefaultApps = {
        "x-scheme-handler/roblox" = ["org.vinegarhq.Sober.desktop"];
        "x-scheme-handler/roblox-player" = ["org.vinegarhq.Sober.desktop"];
      };
    };
    nixcord.enable = true;
    vim.enable = true;
    vinegar.enable = true;

    # todo: make this an attrset idkwtf i was doing
    monitors = [
      {
        name = "HDMI-A-1";
        mode = {
          width = 1920;
          height = 1080;
          refresh = 74.97;
        };
        position = {
          x = 0;
          y = 0;
        };
      }
      {
        name = "DP-1";
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.;
        };
        position = {
          x = 1920;
          y = 0;
        };
      }
    ];

    wallpaper = with config.lib.stylix.colors.withHashtag;
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
  };

  programs.home-manager.enable = true;
}

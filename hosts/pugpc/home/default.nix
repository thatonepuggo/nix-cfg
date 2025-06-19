{
  lib,
  pkgs,
  ...
}: rec {
  imports = [
    ./browser.nix
    ./dunst.nix
    ./ghostty.nix
    ./git.nix
    ./hyprland.nix
    ./obs.nix
    ./rofi.nix
    ./spicetify.nix
    ./themes.nix
    ./vesktop.nix
    ./vim.nix
    ./waybar.nix
    ./zsh.nix
  ];

  home = {
    username = "pug";
    homeDirectory = lib.mkDefault "/home/${home.username}";

    packages = with pkgs; [
      # fun
      fortune
      cowsay
      blahaj
      lolcat
      figlet
      fastfetch
      cava

      # system monitor
      btop

      # tools
      pavucontrol
      cloc

      # gui
      mpv
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

      # alternatives
      eza

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

  programs.home-manager.enable = true;
}

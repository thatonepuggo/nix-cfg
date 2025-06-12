{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: rec {
  imports = [
    ./chromium.nix
    ./dunst.nix
    ./ghostty.nix
    ./git.nix
    ./hyprland.nix
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
      fastfetch
      cava

      # system monitor
      btop

      # tools
      hyprpicker
      grimblast
      hyprpolkitagent

      # langs
      lua

      # games
      doomrunner
      gzdoom
    ];

    # do not edit
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}

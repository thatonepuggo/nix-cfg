{
  config,
  pkgs,
  inputs,
  hostname,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # include modules
    ./boot.nix
    ./mount.nix
    ./users.nix
    ./locale.nix
    ./env.nix
    ./nvidia.nix
    ./sound.nix
    ./steam.nix
    ./stylix.nix
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hostName = hostname;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver.enable = true;

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
    persistent = true;
  };

  # packages

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    file

    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras

    tigervnc

    zip
    unzip

    wl-clipboard
    wl-clip-persist
    cliphist

    libnotify
  ];

  programs.zsh.enable = true;
  programs.nh.enable = true;

  programs.hyprland.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
    update.onActivation = true;
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];

        #Environment = {
        #  # Fix un-themed cursor in some Wayland apps
        #  XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
        #
        #  # Force correct theme for some GTK apps
        #  GTK_THEME = "Adwaita:dark";
        #};
      };

      "org.vinegarhq.Sober" = {
        Context.filesystems = [
          "xdg-run/pipewire-0"
          "xdg-run/app/com.discordapp.Discord:create"
          "xdg-run/discord-ipc-0"
        ];

        Environment = {
          SDL_AUDIO_DRIVER = "pipewire";
        };
      };
    };
  };

  myNixOS = {
    swaylock.enable = true;
    sddm.enable = true;
  };

  # first version installed on this system
  system.stateVersion = "25.05";
}

hostName: {
  config,
  pkgs,
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
    ./wayland.nix
    ./sound.nix
    ./steam.nix
    ./stylix.nix
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    inherit hostName;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # first version installed on this system
  system.stateVersion = "25.05";
}

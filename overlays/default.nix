{inputs, ...}: [
  # additions #
  # bring in custom packages
  #(final: prev: import ../pkgs final.pkgs)

  # modifications #
  #(final: prev: {
  #  config.allowUnfree = true;
  #})

  inputs.nix-your-shell.overlays.default
  inputs.niri.overlays.niri
]

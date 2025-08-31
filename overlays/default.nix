{inputs, ...}: [
  # additions #
  # bring in custom packages
  #(final: prev: import ../pkgs final.pkgs)
  inputs.nix-your-shell.overlays.default
  inputs.niri.overlays.niri

  # modifications #
]

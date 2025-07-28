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

  (final: prev: {
    floorp-unwrapped =
      (prev.floorp-unwrapped.override {
        privacySupport = true;
        webrtcSupport = true;
        enableOfficialBranding = false;
        geolocationSupport = true;
        # https://github.com/NixOS/nixpkgs/issues/418473
        ltoSupport = false;
      }).overrideAttrs (prev: {
        MOZ_DATA_REPORTING = "";
        MOZ_TELEMETRY_REPORTING = "";
      });
  })
]

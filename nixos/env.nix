{config, ...}: {
  environment.variables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];

    # nix
    NIXOS_CONFIG_DIR = "$XDG_CONFIG_HOME/nixos";
    NIXOS_CONFIG = "$XDG_CONFIG_HOME/nixos/configuration.nix";
  };
}

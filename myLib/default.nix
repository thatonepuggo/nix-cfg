inputs: let
  myLib = (import ./default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
  nixpkgs = inputs.nixpkgs;
  lib = nixpkgs.lib;
in rec {
  ## helpers ##

  myOverlays = import ../overlays {inherit inputs outputs;};

  pkgsFor = system:
    import nixpkgs {
      inherit system;
      overlays = myOverlays;
    };

  overlayModule = {
    nixpkgs.overlays = myOverlays;
  };

  systems = [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
  ];

  eachSystem = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

  ## buildables ##

  mkSystem = {
    system,
    hostName,
    nixosConfig,
    homeConfigs,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs outputs myLib hostName;
      };
      modules = [
        (import nixosConfig hostName)
        outputs.nixosModules.default
        overlayModule

        inputs.stylix.nixosModules.stylix
        inputs.niri.nixosModules.niri

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs outputs myLib;
            };
            sharedModules = [
              inputs.spicetify-nix.homeManagerModules.spicetify
              inputs.nixcord.homeModules.nixcord
              inputs.nixvim.homeManagerModules.nixvim
              outputs.homeManagerModules.default
            ];
            backupFileExtension = "bak";
            users = builtins.mapAttrs (username: cfg: import cfg username hostName) homeConfigs;
          };
        }

        #inputs.lix-module.nixosModules.default
      ];
    };

  mkSystems = confs @ {...}:
    builtins.mapAttrs (
      hostName: conf:
        mkSystem (conf // {inherit hostName;})
    )
    confs;
  ## utils ##

  pow = base: exponent: builtins.foldl' (x: _: x * base) 1 (builtins.genList (x: x) exponent);
  bitShiftLeft = x: n: x * (pow 2 n);
  bitShiftRight = x: n: builtins.floor (x / (pow 2 n));
}

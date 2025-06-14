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

  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs myLib;
      };
      modules = [
        config
        outputs.nixosModules.default
        overlayModule
        inputs.lix-module.nixosModules.default
      ];
    };
  
  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor sys;
      extraSpecialArgs = {
        inherit inputs myLib outputs;
      };
      modules = [
        { nixpkgs.config.allowUnfree = true; }
        config
        outputs.homeManagerModules.default
      ];
    };

  ## utils ##

  pow = base: exponent: builtins.foldl' (x: _: x * base) 1 (builtins.genList (x: x) exponent);
  bitShiftLeft = x: n: x * (pow 2 n);
  bitShiftRight = x: n: builtins.floor (x / (pow 2 n));
}

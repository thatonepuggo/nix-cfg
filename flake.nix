{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    home-manager,
    treefmt-nix,
    spicetify-nix,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];

    eachSystem = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

    #treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    inherit lib;
    nixosModules.default = import ./modules/nixos;
    #homeManagerModules.default = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs;};

    packages = eachSystem (pkgs: import ./pkgs { inherit pkgs; });
    devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });
    formatter = eachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      pugpc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit inputs outputs;};
              users.pug = ./home-manager/home.nix;
            };
          }
        ];
      };
    };
  };
}

{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    stylix.url = "github:danth/stylix";

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs:
    with (import ./myLib inputs); {
      devShells = eachSystem (pkgs: import ./shell.nix {inherit pkgs;});
      formatter = eachSystem (pkgs: pkgs.alejandra);

      packages = eachSystem (pkgs: import ./pkgs {inherit pkgs;});

      nixosConfigurations = mkSystems {
        pugpc = {
          system = "x86_64-linux";
          nixosConfig = ./hosts/pugpc/nixos;
          homeConfigs = {
            pug = ./hosts/pugpc/home;
          };
        };
      };

      nixosModules.default = import ./modules/nixos;
      homeManagerModules.default = import ./modules/home;
    };
}

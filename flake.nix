{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
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
  };

  outputs = inputs:
    with (import ./myLib inputs); {
      devShells = eachSystem (pkgs: import ./shell.nix {inherit pkgs;});
      formatter = eachSystem (pkgs: pkgs.alejandra);

      nixosConfigurations = {
        pugpc = mkSystem ./hosts/pugpc/nixos;
      };

      homeConfigurations = {
        "pug@pugpc" = mkHome "x86_64-linux" ./hosts/pugpc/home;
      };

      nixosModules.default = import ./modules/nixos;
      homeManagerModules.default = import ./modules/home-manager;
    };
}

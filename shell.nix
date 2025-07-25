{pkgs ? import ./nixpkgs.nix {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      home-manager
      neovim
      nh
      nix
    ];
  };
}

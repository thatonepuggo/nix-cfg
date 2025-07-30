# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs ? (import ../nixpkgs.nix) {}}: {
  wrapWine = import ./wrapWine.nix { inherit pkgs; };
}

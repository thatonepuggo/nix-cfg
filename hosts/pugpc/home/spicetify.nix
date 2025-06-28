{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      beautifulLyrics
      oneko
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [];
    enabledSnippets = with spicePkgs.snippets; [
      pointer
    ];
  };
}

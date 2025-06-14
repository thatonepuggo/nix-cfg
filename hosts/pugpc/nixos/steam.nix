{
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;

    package = pkgs.steam.override {
      extraPkgs = (pkgs: with pkgs; [    
        pkgsi686Linux.gperftools
      ]);

      extraProfile = let
        gperfPkg = toString pkgs.pkgsi686Linux.gperftools;
      in ''
        export GPERF32_PATH="${gperfPkg}"
      '';
    };

    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      mangohud
    ];
  };

  programs.gamemode.enable = true;
}

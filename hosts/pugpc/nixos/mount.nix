{config, ...}: {
  fileSystems."/mnt/SteamGames" = {
    device = "/dev/disk/by-uuid/6E302188302157FB";
    #label = "SteamGames";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=1000"
      "rw"
      "nofail"
    ];
  };

  fileSystems."/mnt/HL1BootCamp" = {
    device = "/dev/disk/by-uuid/2270-F728";
    fsType = "exfat";
    options = [
      "uid=1000"
      "gid=1000"
      "rw"
      "nofail"
    ];
  };
}

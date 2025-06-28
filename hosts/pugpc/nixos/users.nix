{
  config,
  pkgs,
  ...
}: {
  users.users.pug = {
    isNormalUser = true;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}

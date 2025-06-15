{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "thatonepuggo";
    userEmail = "thatonepuggo@github.com";
  };

  programs.gh.enable = true;
}

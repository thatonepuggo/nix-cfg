{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "thatonepuggo";
    userEmail = "42193477+thatonepuggo@users.noreply.github.com";
  };

  programs.gh.enable = true;
}

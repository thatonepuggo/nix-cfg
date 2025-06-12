{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "monospace";
    };
  };
}

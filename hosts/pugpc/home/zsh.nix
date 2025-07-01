{pkgs, ...}: {
  home.packages = with pkgs; [nix-your-shell];
  home.shell.enableZshIntegration = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza -F --icons --color=auto --sort=type";
      ll = "ls -lh";
      lt = "ls -hSs -1";

      vim = "nvim";
      v = "vim";

      cd = "z";
    };

    autocd = true;

    initContent = ''
      nix-your-shell zsh | source /dev/stdin

      _make_prompt() {
        local _nix_icon=""
        if [ ! -z "$IN_NIX_SHELL" ]; then
          _nix_icon="%F{blue} %f "
        fi
        echo "%~ ''${_nix_icon}%(?.%F{green}.%F{red}%? )%B%#%f%b "
      }

      setopt PROMPT_SUBST
      PROMPT="$(_make_prompt)"
    '';

    history.size = 10000;
  };
}

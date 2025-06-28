{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ nix-your-shell ];
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
      ls = "eza -F --icons --color=auto";
      ll = "ls -lh";
      lt = "ls -hSs -1";

      vim = "nvim";
      v = "vim";
    };

    autocd = true;

    initContent = ''
      nix-your-shell zsh | source /dev/stdin

      if [[ -n $IN_NIX_SHELL ]]; then
        _prompt_nix_icon="%F{blue} %f "
      else
        _prompt_nix_icon=""
      fi

      setopt PROMPT_SUBST
      PROMPT="%~ ''${_prompt_nix_icon}%(?.%F{green}.%F{red}%? )%B%#%f%b "
    '';

    history.size = 10000;
  };
}

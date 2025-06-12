{
  pkgs,
  home,
  ...
}: {
  home.shell.enableZshIntegration = true;

  programs.zsh = {
    enable = true;

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-syntax-highlighting";}
      ];
    };

    shellAliases = {
      ls = "ls -F --color=auto";
      ll = "ls -lh";
      lt = "ls -hSs -1";

      vim = "nvim";
      v = "vim";
    };

    autocd = true;

    initContent = ''
      setopt PROMPT_SUBST
      PROMPT='%~ %(?.%F{green}.%F{red}%? )%B%#%f%b '
    '';

    history.size = 10000;
  };
}

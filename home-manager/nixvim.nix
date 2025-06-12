{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    plugins = {
      lualine.enable = true;
    };

    clipboard.register = "unnamedplus";

    opts = let
      tabSize = 2;
      useSpaces = true;
    in {
      wrap = false;

      mouse = "a";

      # line numbers
      number = true;
      relativenumber = true;

      encoding = "UTF-8";

      # tabs/spaces
      tabstop = tabSize;
      softtabstop = 0;
      shiftwidth = tabSize;
      smarttab = true;
      expandtab = useSpaces;

      # fill in the 80th column
      colorcolumn = "80";
      # fill in the column at the cursor
      cursorcolumn = true;

      # disable code folding
      foldenable = false;

      # completion thing
      wildmode = "longest,list,full";
      wildmenu = true;

      signcolumn = "yes:1";
    };
  };
}

{
  inputs,
  pkgs,
  ...
}: {
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    
    settings.vim = {
      package = pkgs.neovim-unwrapped;

      options = let
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
      
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      lsp.enable = true;
      languages = {
        enableTreesitter = true;
        
        nix.enable = true;
        lua.enable = true;
        ts.enable = true;
        rust.enable = true;
        clang.enable = true;
      };
    };
  };
}

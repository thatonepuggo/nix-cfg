{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      package = pkgs.neovim-unwrapped;

      clipboard.enable = true;

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

      autocmds = [
        {
          desc = "strip trailing whitespace";
          event = ["BufWritePre"];
          pattern = ["*"];
          command = "%s/\\s\\+$//e";
        }
        {
          desc = "create missing directories on save";
          event = ["BufWritePre"];
          pattern = ["*"];
          callback = lib.generators.mkLuaInline ''
            function()
              local fn = vim.fn

              local dir = fn.expand('<afile>:p:h')

              -- This handles URLs using netrw. See ':help netrw-transparent' for details.
              if dir:find('%l+://') == 1 then
                return
              end

              if fn.isdirectory(dir) == 0 then
                fn.mkdir(dir, 'p')
              end
            end
          '';
        }
      ];

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp = {
        enable = true;
        sources = {
          nvim-cmp = null;
          buffer = "[Buffer]";
          path = "[Path]";
        };
      };
      formatter.conform-nvim.enable = true;
      snippets.luasnip.enable = true;

      lsp.enable = true;
      languages = {
        enableTreesitter = true;

        clang.enable = true;
        go.enable = true;
        lua.enable = true;
        nix = {
          enable = true;
          lsp.enable = true;
        };
        python.enable = true;
        rust.enable = true;
        ts.enable = true;
        css.enable = true;
      };

      diagnostics = {
        enable = true;
        config = {
          update_in_insert = true;
        };
      };
    };
  };
}

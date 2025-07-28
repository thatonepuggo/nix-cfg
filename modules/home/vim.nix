{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.myHome.vim;
  helpers = config.lib.nixvim;
in {
  options = {
    myHome.vim = {
      enable = lib.mkEnableOption "nixvim";
    };
  };

  config = {
    programs.nixvim = lib.mkIf cfg.enable {
      enable = true;
      defaultEditor = true;

      plugins = {
        friendly-snippets.enable = true;
        lualine.enable = true;
        luasnip.enable = true;
        notify.enable = true;
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            incremental_selection.enable = true;
            indent.enable = true;
          };
        };
        telescope.enable = true;
        web-devicons.enable = true;
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

      autoCmd = [
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
          callback = helpers.mkRaw ''
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

      lsp = {
        inlayHints.enable = true;
        keymaps = [
          {
            key = "gd";
            lspBufAction = "definition";
          }
          {
            key = "gD";
            lspBufAction = "references";
          }
          {
            key = "gt";
            lspBufAction = "type_definition";
          }
          {
            key = "gi";
            lspBufAction = "implementation";
          }
          {
            key = "K";
            lspBufAction = "hover";
          }
          {
            key = "<leader>k";
            action = helpers.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          }
          {
            key = "<leader>j";
            action = helpers.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
          }
          {
            key = "<leader>lx";
            action = "<CMD>LspStop<Enter>";
          }
          {
            key = "<leader>ls";
            action = "<CMD>LspStart<Enter>";
          }
          {
            key = "<leader>lr";
            action = "<CMD>LspRestart<Enter>";
          }
          {
            key = "gd";
            action = helpers.mkRaw "require('telescope.builtin').lsp_definitions";
          }
          {
            key = "K";
            action = "<CMD>Lspsaga hover_doc<Enter>";
          }
        ];
        servers = {
          nixd.enable = true;
          ts_ls.enable = true;
          lua_ls.enable = true;
          pylsp.enable = true;
          luau_lsp.enable = true;
          rust_analyzer.enable = true;
          clangd.enable = true;
        };
      };

      highlight = {
        NotifyBackground = {
          bg = "#000000";
        };
      };

      filetype.extension = {
        sp = "sourcepawn";
        inc = "sourcepawn";
      };
    };

    stylix.targets.nixvim = {
      plugin = "base16-nvim";
      transparentBackground = {
        main = true;
      };
    };
  };
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      --      Section handles downloading lsps

      local servers = {

        --        csharp_ls = {},
        omnisharp = {
          cmd = { "dotnet",
            "/home/colbysnyd/.local/share/nvimexample/mason/packages/omnisharp/libexec/OmniSharp.dll" },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Old require prior to using servers var and func to setuop
      -- require("lspconfig").lua_ls.setup(servers['lua_ls'] or {})

      --      require 'lspconfig'.omnisharp.setup {}
      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format Lua code
      -- })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)

            --server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          print "attaching"
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- format the current buffer on save
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
          -- if client.supports_method('textDocument/completion') then
          --   -- Create a keymap for vim.lsp.buf.rename()
          --
          -- end
          -- if client.supports_method('textDocument/implementation') then
          --   -- Create a keymap for vim.lsp.buf.implementation
          -- end
        end,
      })
    end
  }
}

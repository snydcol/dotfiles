return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Gets pretty icons, but requires nerd font
      { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },


    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = "󰭎 ",
        }
      }

      --require('telescope.builtin').symbols { sources = { 'nerd' } }
      require('telescope').load_extension('fzf')
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>ec", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")

        }
      end)
      vim.keymap.set("n", "<space>ep", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")

        }
      end)
      -- TODO Fix broken
      require 'config.telescope.multigrep'.setup()
    end
  }
}

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


      --HELP
      --Using <space>f as default start
      --
      --require('telescope.builtin').symbols { sources = { 'nerd' } }
      require('telescope').load_extension('fzf')

      -- Find in directory
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)

      -- Use telescope to  look for nvim config files
      vim.keymap.set("n", "<space>fc", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")

        }
      end)
      -- Use telescope to serch for files used for nvim plugins
      vim.keymap.set("n", "<space>fp", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      require 'config.telescope.multigrep'.setup()
    end
  }
}

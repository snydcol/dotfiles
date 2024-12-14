print("advent")

require("config.lazy")

--Remember :help [Command] will bring up help page

vim.opt.shiftwidth = 4

--Allows pasting from clip board using p
vim.opt.clipboard = "unnamedplus"

vim.g.have_nerd_font = true

--TODO What is <CR>
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")



-- Disable arrow keys in notmal mode
vim.keymap.set('n', "<left>", '<cmd> echo "Use h to move!!"<CR>')
vim.keymap.set('n', "<right>", '<cmd> echo "Use l to move!!"<CR>')
vim.keymap.set('n', "<up>", '<cmd> echo "Use k to move!!"<CR>')
vim.keymap.set('n', "<down>", '<cmd> echo "Use j to move!!"<CR>')

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

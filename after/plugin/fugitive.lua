local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>gs", ':Git<CR>', opts)
keymap("n", "<leader>gp", ':Git push<CR>', opts)


-- trigger comoletion

vim.api.nvim_set_keymap('n', '<silent>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

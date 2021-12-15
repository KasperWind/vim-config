vim.g.asyncrun_open = 30

vim.api.nvim_set_keymap('n', '<leader>bb', ':AsyncRun cargo build<cr><C-w><C-w>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bt', ':AsyncRun cargo test<cr><C-w><C-w>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>br', ':AsyncRun -mode=term -pos=bottom -rows=30 cargo run<cr><C-w><C-w>', { noremap = true, silent = true})

-- ============================================================================
-- Buildin package manager
-- ============================================================================

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', version = 'main' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons.git' },
    { src = 'https://github.com/ibhagwan/fzf-lua.git' },
    { src = 'https://github.com/neovim/nvim-lspconfig.git' },
    { src = 'https://github.com/j-hui/fidget.nvim.git' },
    { src = 'https://github.com/folke/which-key.nvim.git' },
});

-- Treesitter
local ensure_installed = { 'yuck', 'rust', 'zig', 'ini', 'bash', 'htmldjango', 'css', 'markdown', 'hyprlang' }
local treesitter = require('nvim-treesitter')
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})
treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rs', 'yuck', 'zig', 'sh', 'bash', 'html', 'md', 'conf', 'css' },
    callback = function() vim.treesitter.start() end,
})

--which key
require('which-key').setup({})
local wk = require('which-key')

-- nvim web devicons
require('nvim-web-devicons').setup({})

-- fzf lua
wk.add({
    { "<leader>s", group = "FZF lua search" },
})
local fzf_lua = require('fzf-lua')
vim.keymap.set("n", "<leader>sf", function() fzf_lua.files({ resume = false }) end, { desc = "Search for file in workspace" })
vim.keymap.set("n", "<leader>sr", function() fzf_lua.git_files({ resume = false }) end, { desc = "Search for file in repository" })
vim.keymap.set("n", "<leader>sg", function() fzf_lua.live_grep() end, { desc = "Live grep workspace" })
vim.keymap.set("n", "<leader>sb", function() fzf_lua.grep_curbuf() end, { desc = "Grep current buffer" })

-- fidget
require('fidget').setup({})


local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local get_opts = function(desc)
    local t = opts
    t.desc = desc
    return t
end

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", get_opts(""))
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", get_opts(""))
keymap("n", "<C-j>", "<C-w>j", get_opts(""))
keymap("n", "<C-k>", "<C-w>k", get_opts(""))
keymap("n", "<C-l>", "<C-w>l", get_opts(""))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", get_opts(""))
keymap("n", "<C-Down>", ":resize -2<CR>", get_opts(""))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", get_opts(""))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", get_opts(""))

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelete!<CR>", get_opts(""))

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", get_opts(""))
keymap("n", "<S-h>", ":bprevious<CR>", get_opts(""))

-- NvimTree
keymap("n", "<leader>N", ":NvimTreeToggle<CR>", get_opts("Toggle NvimTree"))

-- Oil
keymap("n", "<leader>n", ":Oil<CR>", get_opts("Open Oil.nvim file manager"))

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", get_opts(""))
keymap("v", ">", ">gv", get_opts(""))

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", get_opts(""))
keymap("v", "<A-k>", ":m .-2<CR>==", get_opts(""))
keymap("v", "p", '"_dP', get_opts(""))

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", get_opts(""))
keymap("x", "K", ":move '<-2<CR>gv-gv", get_opts(""))
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", get_opts(""))
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", get_opts(""))

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- Quit
keymap('n', '<C-q>', ':q<CR>', get_opts(""))
keymap('n', '<C-ESC>', ':q<CR>', get_opts(""))

-- Keeps screen for jumping aorund
keymap("n", "J", "mzJ`z", get_opts(""))
keymap("n", "<C-d>", "<C-d>zz", get_opts(""))
keymap("n", "<C-u>", "<C-u>zz", get_opts(""))
keymap("n", "n", "nzzzv", get_opts(""))
keymap("n", "N", "Nzzzv", get_opts(""))

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, get_opts(""))
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, get_opts(""))
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, get_opts(""))
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, get_opts(""))

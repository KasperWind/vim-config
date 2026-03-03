-- ============================================================================
-- KEYMAPS
-- ============================================================================

local wk = require('which-key')

--
-- Normal mode mappings
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>bdelete!<CR>", { desc = "Close buffer" })

-- Buffer navigation
wk.add({
    { "<leader>b", group = "Buffer operations" },
})
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Movement in wrapped text
vim.keymap.set("n", "j", function ()
    return vim.v.count == 0 and "gj" or "j"
end, {desc = "Down (wrap-aware)", expr = true, silent = true})
vim.keymap.set("n", "k", function ()
    return vim.v.count == 0 and "gk" or "k"
end, {desc = "Up (wrap-aware)", expr = true, silent = true})


-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-q>", ":quit<CR>", { desc = "Close window" })

-- Splitting & Resizing
wk.add({
    { "<leader>w", group = "Buffer operations" },
})
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Build and other
vim.keymap.set("n", "<leader>m", ":make<CR>", { desc = "Run make for current buffer."});

-- Lua remaps
vim.keymap.set('n', '<leader><leader>r', '<cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>r', ':.lua<CR>', { desc = 'Lua run current line' })
vim.keymap.set('v', '<leader>r', ':lua<CR>', { desc = 'Lua run current selection' })

-- local ok, undo_tree = pcall(require, "undo_tree")
-- if not ok then
--   print("undo tree not loaded")
--   return
-- end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<leader>ut", vim.cmd.UndotreeToggle, opts)

-- Set leader key before anything else
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key 

require('packages')
require('options')
require('keymaps')
require('functions')
require('plugins')
require('lsp')

-- TODO:
-- [X] colors
-- [ ] status line (lualine)
-- [ ] trouble
-- [ ] debug
-- [ ] omnisharp

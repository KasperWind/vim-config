-- Set leader key before anything else
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key 
require('packages')
require('options')
require('keymaps')
require('functions')
require('theme')
require('plugins')
require('lsp')
require('lsp_server_settings')
require('debug_setup')

-- TODO:
-- [X] colors
-- [X] status line (lualine)
-- [X] omnisharp
-- [ ] debug
-- [ ] trouble, wait with that one

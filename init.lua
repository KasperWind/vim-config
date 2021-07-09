-- Helpers
local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
local bo = vim.bo

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Set colorscheme (order is important here)
vim.g.onedark_style = 'warm'
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2

cmd('colorscheme onedark')
cmd('highlight LineNr ctermfg=yellow')

--Set statusbar
vim.g.lightline = { colorscheme = 'onedark';
      active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } };
      component_function = { gitbranch = 'fugitive#head', };
}

require('plugins')

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- global options
o.swapfile = false
o.dir = '/tmp'
o.smartcase = true
o.errorbells = false
o.backup = false
o.hidden = true
o.incsearch = true
o.hlsearch = false
o.inccommand = "nosplit"
o.completeopt = "menuone,noinsert,noselect"
o.scrolloff = 12 
o.splitbelow = true	
o.splitright = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.cmdheight = 1	

-- window-local options

wo.relativenumber = true
wo.number = true
wo.wrap = false
wo.signcolumn = "yes"
wo.colorcolumn = "100"

-- buffer-local options

bo.expandtab = true
bo.syntax = "on"
bo.smartindent = true

require('tresitterInit')
require('telescopeInit')
require('compleInit')
require('lspInit')
require('vimspectorInit')
require('vimclangformatInit')

--Set colorscheme (order is important here)
vim.g.onedark_style = 'warm'
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2

vim.cmd('colorscheme onedark')
vim.cmd('highlight LineNr ctermfg=yellow')

--Set statusbar
vim.g.lightline = { colorscheme = 'onedark';
      active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } };
      component_function = { gitbranch = 'FugitiveHead', };
}


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = "none", -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder", -- highlight group used for the documentation window
    max_width = 120,
    min_width = 40,
    max_height = math.floor(vim.o.lines * 0.5),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}


vim.api.nvim_set_keymap('i', '<expr><C-Space>', [[<cmd>compe#complete()]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<expr><CR>'     , [[<cmd>compe#confirm('<CR>')]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<expr><C-e>'    , [[<cmd>compe#close('<C-e>')]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<expr><C-f>'    , [[<cmd>compe#scroll({ 'delta': +4 })]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<expr><C-d>'    , [[<cmd>compe#scroll({ 'delta': -4 })]], { noremap = true, silent = true})

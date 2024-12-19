vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.cmd.colorscheme("sorbet")

require("lazy").setup("plugins")

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

vim.filetype.add({
  extension = {
    st = "st",
  },
})

-- parser_config.st = {
--   install_info = {
--     url = "/home/kasperw/repos/tree-sitter-structured-text",   -- local path or git repo
--     files = { "src/parser.c" },             -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     branch = "main",                        -- default branch in case of git repo if different from master
--     -- generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
--     -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "st",                          -- if filetype does not match the parser name
-- }
--
-- vim.treesitter.language.register('st', 'st')  -- the someft filetype will use the python parser and queries.
--
-- vim.filetype.add({
--   extension = {
--     c3 = "c3",
--     c3i = "c3",
--     c3t = "c3",
--   },
-- })
--
-- parser_config.c3 = {
--   install_info = {
--     url = "https://github.com/c3lang/tree-sitter-c3",
--     files = {"src/parser.c", "src/scanner.c"},
--     branch = "main",
--   },
-- }

require("options")
require("keymaps")
require("filetypes")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

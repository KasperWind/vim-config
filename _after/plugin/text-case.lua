local status_ok, text_case = pcall(require, "textcase")
if not status_ok then
  print("text-case not found")
  return
end

text_case.setup();

local status_tok, telescope = pcall(require, "telescope")
if not status_tok then
  print("text-case telescope not found")
  return
end

telescope.load_extension('textcase')
vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })

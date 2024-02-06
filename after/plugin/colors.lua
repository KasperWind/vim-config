-- use command line :set background=light 

local temp = os.date("*t", os.time())
local h = tonumber(temp.hour)
if h >= 8 and h < 20 then
  -- vim.o.background = "light"
  vim.o.background = "dark"
else
  vim.o.background = "dark"
end

-- vim.g.gruvbox_material_better_performance = 1
--vim.cmd [[colorscheme gruvbox-material]]
--
--
require("catppuccin").setup({
  background = {
    light = "latte",
    dark = "mocha",
  },
  integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = false,
  }
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
  },
}

vim.cmd.colorscheme "catppuccin"


return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { 
      "folke/neoconf.nvim",
      cmd = "Neoconf" 
  },
  { "catppuccin/nvim", 
      name = "catppuccin",
      priority = 1000,
      config = function()
        vim.cmd.colorscheme "catppuccin"
      end
  },
}

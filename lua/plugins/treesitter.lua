local ensure_installed = { 
    "c",
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "html"
}
return {
      {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = ensure_installed,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end,
  },
}

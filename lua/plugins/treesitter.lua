local ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "html",
    "zig"
}
return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context'
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
            local tree_context_status_ok, context = pcall(require, "treesitter-context")
            if not tree_context_status_ok then
                print("treesitter context not loaded")
                return
            end

            context.setup()
        end,
  },
}

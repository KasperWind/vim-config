return {
    {
        "nvim-lua/popup.nvim",
    },
    {
        "nvim-lua/plenary.nvim",
    },
    "folke/neodev.nvim",
    "folke/which-key.nvim",
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf"
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end
    },
    {
        "mbbill/undotree",
        opts = {},
        config = function()
            local opts = { noremap = true, silent = true }
            local keymap = vim.keymap.set
            keymap("n", "<leader>ut", vim.cmd.UndotreeToggle, opts)
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    }
}

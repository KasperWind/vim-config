return {
    {
        "nvim-lua/popup.nvim",
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "folke/neodev.nvim",
        opts = {},
    },
    {
        "folke/which-key.nvim",
        opts = {},
    },
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo telescope" }
        },
        opts = {},
    },
    {
        "RRethy/nvim-base16",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = 'jellybeans',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
            },
        },
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
    },
    {
        'fei6409/log-highlight.nvim',
        config = function()
            require('log-highlight').setup {}
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}

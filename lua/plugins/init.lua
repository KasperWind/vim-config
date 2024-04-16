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
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = 'jellybeans',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
            },
            extensions = {
                'quickfix',
                'oil',
                'trouble',
                'mason',
                'fugitive',
            }
        },
    },
    {
        "mbbill/undotree",
        opts = {},
        keys = {
            { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Todo telescope" }
        },
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "<leader>a", "<cmd>lua require('harpoon'):list():add()<CR>", desc = "Harpoon [A]dd file to list" },
            { "<leader>h", "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>", desc = "Harpoon [A]dd file to list" },
        },
    },

    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "fei6409/log-highlight.nvim",
        config = function()
            require("log-highlight").setup {}
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>S",  "<cmd>lua require('spectre').toggle()<CR>",                             desc = "Toggle spectre",         mode = { "n", "v" } },
            { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",      desc = "Search current word",    mode = { "n", "v" } },
            { "<leader>sp", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", desc = "Search on current file", mode = { "n", "v" } },
        },
    },
}

-- vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
--     desc = "Toggle Spectre"
-- })
-- vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--     desc = "Search current word"
-- })
-- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--     desc = "Search current word"
-- })
-- vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--     desc = "Search on current file"
-- })

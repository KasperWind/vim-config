local function get_current_working_directory ()
    return vim.fn.getcwd()
end
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
                theme = 'gruvbox',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_c = { 'windows', get_current_working_directory  },
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
            { "<leader>a", function() require('harpoon'):list():add() end,                                    desc = "Harpoon [A]dd file to list" },
            { "<leader>h", function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = "Open Harpoon quick menu" },
            { "<A-h>",  function() require('harpoon'):list():select(1) end, desc = "Opens file 1 in harpoon list" },
            { "<A-j>",  function() require('harpoon'):list():select(2) end, desc = "Opens file 1 in harpoon list" },
            { "<A-k>",  function() require('harpoon'):list():select(3) end, desc = "Opens file 1 in harpoon list" },
            { "<A-l>",  function() require('harpoon'):list():select(4) end, desc = "Opens file 1 in harpoon list" },
            { "<A-p>",  function() require('harpoon'):list():prev() end, desc = "Harpoon previuos" },
            { "<A-n>",  function() require('harpoon'):list():next() end, desc = "Harpoon next" },
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
        opts = {
            keymaps = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["<C-r>"] = "actions.refresh",
            }
        },
        keys = {
            {
                "<leader>ns",
                function()
                    require('oil').open()
                    local start = vim.api.nvim_get_current_win()
                    vim.cmd('vsplit')
                    local win = vim.api.nvim_get_current_win()
                    local buf = vim.api.nvim_create_buf(true, true)
                    vim.api.nvim_win_set_buf(win, buf)
                    local pwd = vim.fn.getcwd()
                    require('oil').open(pwd)
                    vim.api.nvim_set_current_win(start)
                end,
                desc = "Oil.nvim open split view",
                mode = { "n", "v" }
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "albenisolmos/telescope-oil.nvim",
        lazy = false,
        keys = {
            { "<leader>no", "<cmd>lua require('telescope').extensions.oil.oil()<CR>", desc = "Oil.nvim open telescope diaglog", mode = { "n", "v" } },
        },
        config = function()
            require("telescope").load_extension("oil")
        end,
        dependencies = { "stevearc/oil.nvim", "nvim-telescope/telescope.nvim", },
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
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

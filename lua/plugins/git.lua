return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",      -- optional
        },
        keys = {
            { "<leader>gs",  ':Neogit<CR>',                                            desc = "Open [G]it [S]tatus" },
        },
        config = true
    },
    -- {
    --     'tpope/vim-fugitive',
    --     opts = {
    --     },
    --     keys = {
    --         { "<leader>gs",  ':Git<CR>',                                            desc = "Open [G]it [S]tatus" },
    --         { "<leader>gp",  ':Git push<CR>',                                       desc = "[G]it [p]ush" },
    --         { "<leader>gP",  ':Git pull<CR>',                                       desc = "[G]it [p]ull" },
    --         { "<leader>ggd", ':Git diff<CR>',                                       desc = "[G]it [D]iff" },
    --         { "<leader>gl",  ':Git log --abbrev-commit<CR>',                        desc = "[G]it [L]og" },
    --         { "<leader>ggl", ':Git log --pretty=short --graph --abbrev-commit<CR>', desc = "[G]it [L]og" },
    --     },
    -- },
    'tpope/vim-rhubarb',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup(
                {
                    signs                        = {
                        add          = { text = '┃' },
                        change       = { text = '┃' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                    signs_staged                 = {
                        add          = { text = '┃' },
                        change       = { text = '┃' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                    signs_staged_enable          = true,
                    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
                    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
                    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                    watch_gitdir                 = {
                        follow_files = true
                    },
                    auto_attach                  = true,
                    attach_to_untracked          = false,
                    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts      = {
                        virt_text = true,
                        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                        delay = 1000,
                        ignore_whitespace = false,
                        virt_text_priority = 100,
                    },
                    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                    sign_priority                = 6,
                    update_debounce              = 100,
                    status_formatter             = nil,   -- Use default
                    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                    preview_config               = {
                        -- Options passed to nvim_open_win
                        border = 'single',
                        style = 'minimal',
                        relative = 'cursor',
                        row = 0,
                        col = 1
                    },
                }
            )
        end
    },
}

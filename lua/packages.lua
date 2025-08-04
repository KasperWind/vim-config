-- ============================================================================
-- Buildin package manager
-- ============================================================================

local function build_blink(path)
    vim.notify('Building blink.cmp', vim.log.levels.INFO)
    local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = path }):wait()
    if obj.code == 0 then
        vim.notify('Building blink.cmp done', vim.log.levels.INFO)
    else
        vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(event)
        if event.data.kind ~= 'delete' then
            if event.data.spec.name == 'blink.cmp' then
                build_blink(event.data.path)
            end
            if event.data.spec.name == 'treesitter' then
                require('nvim-treesitter').update()
            end
        end
    end
})

vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', version = 'main' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons.git' },
    { src = 'https://github.com/ibhagwan/fzf-lua.git' },
    { src = 'https://github.com/neovim/nvim-lspconfig.git' },
    { src = 'https://github.com/j-hui/fidget.nvim.git' },
    { src = 'https://github.com/folke/which-key.nvim.git' },
    { src = 'https://github.com/folke/todo-comments.nvim.git' },
    { src = 'https://github.com/Saghen/blink.cmp.git' },
    { src = 'https://github.com/xzbdmw/colorful-menu.nvim.git' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim.git' },
    { src = 'https://github.com/sindrets/diffview.nvim.git' },
    { src = 'https://github.com/nvim-lua/plenary.nvim.git' },
    { src = 'https://github.com/NeogitOrg/neogit.git' },
    { src = 'https://github.com/ThePrimeagen/harpoon.git',            version = 'harpoon2' },
    { src = 'https://github.com/stevearc/oil.nvim.git' }
});

-- Treesitter
local ensure_installed = {
    'yuck',
    'rust',
    'zig',
    'ini',
    'bash',
    'htmldjango',
    'css',
    'markdown',
    'hyprlang',
}

local patterns = {
    'rs',
    'yuck',
    'zig',
    'sh',
    'bash',
    'html',
    'md',
    'conf',
    'css',
}

local treesitter = require('nvim-treesitter')
treesitter.setup({
    install_dir = vim.fn.stdpath('data') .. '/site',
})
treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
    pattern = patterns,
    callback = function() vim.treesitter.start() end,
})

-- fzf lua
local wk = require('which-key')
wk.add({
    { "<leader>s", group = "FZF lua search" },
})
local fzf_lua = require('fzf-lua')
vim.keymap.set("n", "<leader>sf", function() fzf_lua.files({ resume = false }) end,
    { desc = "Search for file in workspace" })
vim.keymap.set("n", "<leader>sr", function() fzf_lua.git_files({ resume = false }) end,
    { desc = "Search for file in repository" })
vim.keymap.set("n", "<leader>sg", function() fzf_lua.live_grep() end, { desc = "Live grep workspace" })
vim.keymap.set("n", "<leader>sb", function() fzf_lua.grep_curbuf() end, { desc = "Grep current buffer" })
vim.keymap.set("n", "<leader>sm", function() fzf_lua.manpages() end, { desc = "Search man pages" })

-- blink
require('blink.cmp').setup({
    sources = {
        default = { 'lsp', 'path', 'buffer' },
    },
    signature = { enabled = true },
    completion = {
        documentation = {
            auto_show = true,
        },
        menu = {
            draw = {
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            },
        },
    },
})

-- neogit
wk.add({
    { "<leader>g", group = "Git integrated functions" },
})

local neogit = require('neogit')
vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Git status view" })

-- todo comments
require('todo-comments').setup({})
local todo = require('todo-comments.fzf')
vim.keymap.set("n", "<leader>st", todo.todo, { desc = "Search todo's" })

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add current buffer" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Harpoon add current buffer" })
vim.keymap.set("n", "<A-h>", function() harpoon:list():select(1) end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-j>", function() harpoon:list():select(2) end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-k>", function() harpoon:list():select(3) end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-l>", function() harpoon:list():select(4) end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-p>", function() harpoon:list():prev() end, { desc = "Harpoon previuos" })
vim.keymap.set("n", "<A-n>", function() harpoon:list():next() end, { desc = "Harpoon next" })

-- oil
require('oil').setup({
    keymaps = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<C-r>"] = "actions.refresh",
    }
})
local oil = require('oil')
local open_split = function()
    oil.open()
    local start = vim.api.nvim_get_current_win()
    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    local pwd = vim.fn.getcwd()
    oil.open(pwd)
    vim.api.nvim_set_current_win(start)
end
vim.keymap.set("n", "<leader>ns", open_split, { desc = "Oil open split" })
vim.keymap.set("v", "<leader>ns", open_split, { desc = "Oil open split" })

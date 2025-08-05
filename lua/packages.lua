-- ============================================================================
-- Buildin package manager load
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
    { src = 'https://github.com/stevearc/oil.nvim.git' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim.git' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim.git' },
    { src = 'https://github.com/Hoffs/omnisharp-extended-lsp.nvim.git' },
    { src = 'https://github.com/mfussenegger/nvim-dap.git' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui.git' },
    { src = 'https://github.com/nvim-neotest/nvim-nio.git' },
})


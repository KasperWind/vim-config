-- ============================================================================
-- LSP
-- ============================================================================

local servers = {
    'lua_ls',
    'rust_analyzer',
    'clangd',
    'omnisharp',
    'fsautocomplete',
    'ts_ls',
    'jsonls',
    'html',
    'cssls',
    'zls',
    'lemminx',
}

for _, server in pairs(servers) do
    vim.lsp.enable(server)
end

local wk = require('which-key')
wk.add({
    { "<leader>l", group = "LSP functions" },
    { "<leader>b", group = "Build, debug and run" },
})

-- Better LSP UI
vim.diagnostic.config({
    virtual_text = { prefix = '●' },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        }
    }
})

vim.api.nvim_create_user_command('LspInfo', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        print("No LSP clients attached to current buffer")
    else
        for _, client in ipairs(clients) do
            print("LSP: " .. client.name .. " (ID: " .. client.id .. ")")
        end
    end
end, { desc = 'Show LSP client info' })


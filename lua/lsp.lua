-- ============================================================================
-- LSP
-- ============================================================================

local servers = {
    'lua_ls',
    'rust_analyzer',
    'clangd',
}

for _, server in pairs(servers) do
    vim.lsp.enable(server)
end

local wk = require('which-key')
wk.add({
    { "<leader>l", group = "LSP functions" },
})

-- LSP keymaps
local fzf_lua = require('fzf-lua')
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = function(desc)
            return { buffer = event.buf, desc = desc }
        end
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
            if client:supports_method({ 'textDocumet/completion' }) then
                vim.lsp.completion.enable(true, client.id, event.buf, {
                    autotrigger = false,
                })
                vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "LSP: Trigger completion" })
            end
        end

        -- Navigation
        vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts('LSP: Go to definition'))
        vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, opts('LSP: Go to declaration'))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('LSP: Go to referrences'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('LSP: Go to implemention'))
        vim.keymap.set('n', '<leader>sw', fzf_lua.lsp_workspace_symbols, opts('LSP: Search Workspace Symbols'))
        vim.keymap.set('n', '<leader>ss', fzf_lua.lsp_document_symbols, opts('LSP: Search Document Symbols'))

        -- Information
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('LSP: Buffer Hover'))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts('LSP: Signature help'))

        -- Code actions
        vim.keymap.set('n', '<leader>la', fzf_lua.lsp_code_actions, opts('LSP: Code Action'))
        vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts('LSP: Rename symbol'))
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts('LSP: Format document'))

        -- Diagnostics
        vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts('LSP: Show diagnostic'))
        vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, opts('LSP: Buffer diagnostic to location list'))
        vim.keymap.set('n', '<leader>sd', fzf_lua.lsp_document_diagnostics, opts('LSP: Search document diagnostic'))
    end,
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

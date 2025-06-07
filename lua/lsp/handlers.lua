local M = {}

local diagnostic_active = vim.diagnostic.is_enabled()

local function toggle_diagnostic()
    diagnostic_active = not diagnostic_active
    if diagnostic_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require('blink.cmp').get_lsp_capabilities(M.capabilities)

M.setup = function()
    vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
            text = {
                [vim.diagnostic.severity.ERROR] = '󰅚 ',
                [vim.diagnostic.severity.WARN] = '󰀪 ',
                [vim.diagnostic.severity.INFO] = '󰋽 ',
                [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
        } or {},
        virtual_text = {
            source = 'if_many',
            spacing = 2,
            format = function(diagnostic)
                local diagnostic_message = {
                    [vim.diagnostic.severity.ERROR] = diagnostic.message,
                    [vim.diagnostic.severity.WARN] = diagnostic.message,
                    [vim.diagnostic.severity.INFO] = diagnostic.message,
                    [vim.diagnostic.severity.HINT] = diagnostic.message,
                }
                return diagnostic_message[diagnostic.severity]
            end,
        },
    }
end

M.callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = '[L]SP: ' .. desc })
    end

    local telescope = require('telescope.builtin')
    map("<leader>la", vim.lsp.buf.code_action, "Show Code [A]ctions")
    map("<leader>lr", vim.lsp.buf.rename, '[R]ename symbol under cursor')
    map("<leader>lf", function() vim.lsp.buf.format { async = true } end, "[F]ormat document")
    map("<leader>ls", vim.lsp.buf.signature_help, "[S]ignature help")
    map("<C-k>", vim.lsp.buf.signature_help, "signature help (insert mode)", "i")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>lq", vim.diagnostic.setloclist, "diagnostic open [Q]uick list")
    map("gl", vim.diagnostic.open_float, "diagnostic open float")

    map("gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
    map("gd", vim.lsp.buf.definition, "[G]o to [d]efinition")
    map("gI", vim.lsp.buf.implementation, "[G]o to [I]mplementation")
    map("gr", vim.lsp.buf.references, "show [R]eferences")
    map('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
    map('gO', telescope.lsp_document_symbols, '[O]pen Document Symbols')
    map('gW', telescope.lsp_dynamic_workspace_symbols, 'Open [W]orkspace Symbols')

    local function client_supports_method(client_, method, buf_nr)
        if vim.fn.has 'nvim-0.11' == 1 then
            return client_:supports_method(method, buf_nr)
        else
            return client_.supports_method(method, { bufnr = buf_nr })
        end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('wind-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('wind-lsp-detach', { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'wind-lsp-highlight', buffer = event2.buf }
            end,
        })
    end
    local function toggle_inlay()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        vim.keymap.set('n', '<leader>th', toggle_inlay, { desc = 'LSP: [T]oggle Inlay [H]ints' })
    end
    vim.keymap.set('n', '<leader>td', toggle_diagnostic, { desc = 'LSP: [T]oggle [D]iagnostic' })

    local require_ok, client_opts = pcall(require, "lsp.settings." .. client.name)
    if require_ok and client_opts.on_attach ~= nil then
        client_opts.on_attach(event)
    end
end

return M

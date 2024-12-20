local function lsp_keymaps(bufnr)
    local opts = function(desc)
        return { desc = desc, noremap = true, silent = true }
    end
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("LSP: go to declaration"))
    keymap(bufnr, "n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<CR>", opts("LSP: go to definition"))
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts("LSP: Hover documentation"))
    keymap(bufnr, "n", "gI", "<cmd>lua require('omnisharp_extended').lsp_implementation()<CR>", opts("LSP: go to Implementation"))
    keymap(bufnr, "n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<CR>", opts("LSP: show references"))
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts("LSP: diagnostic open float"))
    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts("LSP: format document"))
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts("LSP: info"))
    keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts("LSP: install info"))
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts("LSP: Show Code Action list"))
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
        opts("LSP: go to next diagnostic"))
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
        opts("LSP: go to previous diagnostic"))
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts("LSP: rename symbol under cursor"))
    keymap(bufnr, "n", "<leader>lR", "<cmd>LspRestart<cr>", opts("LSP: Restart (recompile)"))
    keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("LSP: Signature help"))
    keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("LSP: signature help (insert mode)"))
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts("LSP: diagnostic open quick list"))
end

require 'lspconfig'.omnisharp.setup {
    -- cmd = { "/Program Files/omnisharp-win-x64-net6.0/OmniSharp.exe" },
    cmd = {"dotnet" , "/Program Files/omnisharp-win-x64-net6.0/OmniSharp.dll" },

    capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),

    on_attach_required = function(client, bufnr)
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        lsp_keymaps(bufnr)
        local status_ok, illuminate = pcall(require, "illuminate")
        if not status_ok then
            return
        end
        illuminate.on_attach(client)
    end,

    on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        lsp_keymaps(bufnr)
        local status_ok, illuminate = pcall(require, "illuminate")
        if not status_ok then
            return
        end
        illuminate.on_attach(client)
    end,

    setup = function()
        local signs = {

            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end

        local config = {
            virtual_text = true, -- disable virtual text
            signs = {
                active = signs, -- show signs
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }

        vim.diagnostic.config(config)

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })
    end,

    settings = {
        FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = true,
        },
        -- MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            -- LoadProjectsOnDemand = nil,
        -- },
        -- RoslynExtensionsOptions = {
        --     -- Enables support for roslyn analyzers, code fixes and rulesets.
        --     EnableAnalyzersSupport = true,
        --     -- Enables support for showing unimported types and unimported extension
        --     -- methods in completion lists. When committed, the appropriate using
        --     -- directive will be added at the top of the current file. This option can
        --     -- have a negative impact on initial completion responsiveness,
        --     -- particularly for the first few completion sessions after opening a
        --     -- solution.
        --     EnableImportCompletion = true,
        --     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        --     -- true
        --     AnalyzeOpenDocumentsOnly = false,
        -- },
        Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
        },
    },
}

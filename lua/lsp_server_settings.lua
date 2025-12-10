-- ============================================================================
-- LSP server settings
-- ============================================================================

-- LSP keymaps
local fzf_lua = require('fzf-lua')
local functions = require('functions')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = function(desc)
            return { buffer = event.buf, desc = desc }
        end
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Navigation
        vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts('LSP: Go to definition'))
        vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, opts('LSP: Go to declaration'))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('LSP: Go to referrences'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('LSP: Go to implemention'))
        vim.keymap.set('n', '<leader>sw', fzf_lua.lsp_workspace_symbols, opts('LSP: Search Workspace Symbols'))
        vim.keymap.set('n', '<leader>ss', fzf_lua.lsp_document_symbols, opts('LSP: Search Document Symbols'))

        -- Information
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts('LSP: Buffer Hover'))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts('LSP: Signature help'))
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts('LSP: Signature help'))

        -- Code actions
        vim.keymap.set('n', '<leader>la', fzf_lua.lsp_code_actions, opts('LSP: Code Action'))
        vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts('LSP: Rename symbol'))
        vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts('LSP: Format document'))

        -- Diagnostics
        vim.keymap.set('n', '<leader>lt', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, opts('LSP: Toggle document diagnostic'))
        vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts('LSP: Show diagnostic'))
        vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, opts('LSP: Buffer diagnostic to location list'))
        vim.keymap.set('n', '<leader>sd', fzf_lua.lsp_document_diagnostics, opts('LSP: Search document diagnostic'))


        if client ~= nil then
            if client.name == 'rust_analyzer' then
                require('rust')
                vim.keymap.set("n", "<leader>bb", "<cmd>CargoBuild<CR>", opts("Cargo build"))
                vim.keymap.set("n", "<leader>br", "<cmd>CargoRun<CR>", opts("Cargo run"))
                vim.keymap.set("n", "<leader>bt", "<cmd>CargoTest<CR>", opts("Cargo test"))

                local path = client.workspace_folders[1].name .. "/.cargo/config.toml"
                local filereadable = vim.fn.filereadable(path)
                if filereadable == 1 then
                    local _ = vim.fn.readfile(path)
                    client.config.settings["rust-analyzer"].cargo.target = "armv7a-none-eabi"
                    client.config.settings["rust-analyzer"].check.allTargets = false
                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
            elseif client.name == 'omnisharp' then
                require('omnisharp')
                vim.keymap.set("n", "<leader>bb", "<cmd>OmniSharpBuild<CR>", opts("Dotnet build"))
                vim.keymap.set("n", "<leader>br", "<cmd>OmniSharpRun<CR>", opts("Dotnet run"))
                vim.keymap.set("n", "<leader>bt", "<cmd>OmniSharpTest<CR>", opts("Dotnet run tests"))
                vim.cmd.compiler('dotnet')

                -- local omni = require('omnisharp_extended')
                --
                -- vim.keymap.set("n", "gd", omni.lsp_definition, opts("LSP: go to definition"))
                -- vim.keymap.set("n", "gD", omni.lsp_type_definition, opts("LSP: go to declaration"))
                -- vim.keymap.set("n", "gr", omni.lsp_references, opts("LSP: show references"))
                -- vim.keymap.set("n", "gi", omni.lsp_implementation, opts("LSP: go to implementation"))
            elseif client.name == 'fsautocomplete' then
                vim.keymap.set("n", "<leader>bb", "<cmd>make<CR>", opts("Dotnet build"))
                vim.keymap.set("n", "<leader>br", "<cmd>!dotnet run<CR>", opts("Dotnet run"))
                vim.cmd.compiler('dotnet')
            elseif client.name == 'ts_ls' then
                vim.keymap.set("n", "<leader>br", "<cmd>term bun %<CR>", opts("Bun run, current file"))
            end
        end

        if client and functions.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set('n', '<leader>lh', functions.toggle_inlay, { desc = 'LSP: Toggle Inlay Hints' })
        end
    end,
})

-- rust rust_analyzer
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                -- target = "thumbv7em-none-eabihf",
                -- target = "armv7a-none-eabi",
                buildScripts = {
                    enable = true,
                },
            },
            check = {
                -- allTargets = false,
            },
            procMacro = {
                enable = true,
                ignored = {
                    leptos_macro = {
                        "server",
                    },
                },
            },
        },
    }
})

-- omnisharp
vim.lsp.config('omnisharp', {
    cmd = {
        vim.fn.executable('OmniSharp') == 1 and 'OmniSharp' or 'omnisharp',
        '-z',     -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
        '--hostPID',
        tostring(vim.fn.getpid()),
        'DotNet:enablePackageRestore=false',
        '--encoding',
        'utf-8',
        '--languageserver',
    },
    settings = {
        FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
        },
        MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
        },
        RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = true,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = nil,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
            -- Enables the possibility to see the code in external nuget dependencies
            EnableDecompilationSupport = true,
        },
        RenameOptions = {
            RenameInComments = nil,
            RenameOverloads = nil,
            RenameInStrings = nil,
        },
        Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
        },
    },
})

-- ts_ls


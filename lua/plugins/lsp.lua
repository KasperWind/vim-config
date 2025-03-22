local ensure_installed = {
    'lua_ls',
    'clangd',
    'ts_ls',
    --	"asm_lsp",
    --	"cssls",
    "html",
    --	"pyright",
    --	"bashls",
    "jsonls",
    --	"yamlls",
    --  "gopls",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    --	"hls",
    --	"ocamllsp",
    --	"cmake",
    --	"taplo",
    "omnisharp",
    "sqlls"
}
local ensure_setup = {
    "zls",
    -- "omnisharp",
    "jsonls",
    "gopls",
    "ols"
}
return {
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            {
                "j-hui/fidget.nvim",
                opts = {},
            },
        },
        config = function()
            require("neoconf").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_installation = true,
            })
            local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
            if not lspconfig_status_ok then
                return
            end

            local handlers = require("lsp.handlers")

            for _, server in pairs(ensure_installed) do
                local opts = {}
                opts = {
                    on_attach = handlers.on_attach,
                    capabilities = handlers.capabilities,
                }

                server = vim.split(server, "@")[1]
                local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
                if require_ok then
                    local a = conf_opts.on_attach
                    if a ~= nil then
                        opts.on_attach = a
                    end
                    opts = vim.tbl_deep_extend("force", conf_opts, opts)
                end

                lspconfig[server].setup(opts)
            end
            for _, server in pairs(ensure_setup) do
                local opts = {}
                opts = {
                    on_attach = handlers.on_attach,
                    capabilities = handlers.capabilities,
                }

                server = vim.split(server, "@")[1]

                local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
                if require_ok then
                    opts = vim.tbl_deep_extend("force", conf_opts, opts)
                end

                lspconfig[server].setup(opts)
            end
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        --        "quick-lint/quick-lint-js",
        --        tag = '3.2.0',
        --       cond = function(plugin)
        --           -- TODO(strager): Don't make this happen multiple times.
        --           plugin.dir = plugin.dir .. "/plugin/vim/quick-lint-js.vim"
        --           return true
        --       end,
        --       config = function()
        --           require("lspconfig/quick_lint_js").setup {}
        --       end,
    },
}

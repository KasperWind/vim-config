local ensure_installed = {
    'lua_ls',
    'clangd',
    'tsserver',
--	"asm_lsp",
--	"cssls",
--	"html",
--	"pyright",
--	"bashls",
--	"jsonls",
--	"yamlls",
--  "gopls",
    "rust_analyzer",
--  "svelte",
--	"hls",
--	"ocamllsp",
--	"cmake",
--	"taplo",
--	"sqlls"
--  "zls"
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
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                automatic_installation = true,
            })
            local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
            if not lspconfig_status_ok then
                return
            end

            local opts = {}

            local handlers = require("lsp.handlers")

            for _, server in pairs(ensure_installed) do
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
}

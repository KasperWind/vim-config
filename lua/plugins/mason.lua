local ensure_installed = {
    'lua_ls',
    'clangd'
}
return {
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-path", -- path completions
            "hrsh7th/cmp-cmdline", -- cmdline completions
            "saadparwaiz1/cmp_luasnip", -- snippet completions
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
    }
}

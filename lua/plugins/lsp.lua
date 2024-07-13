local ensure_installed = {
    'lua_ls',
    'clangd',
    'tsserver',
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
    "omnisharp",
    "jsonls"
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
            for _, server in pairs(ensure_setup) do
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
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
        },
        keys = {
            { "<leader>xx", function() require("trouble").toggle() end,                        desc = "Toggle Trouble" },
            { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Trouble workspace diagnostics" },
            { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,  desc = "Trouble document diagnostics" },
            { "<leader>xq", function() require("trouble").toggle("quickfix") end,              desc = "Trouble to quickfix list" },
            { "<leader>xl", function() require("trouble").toggle("loclist") end,               desc = "Trouble to loation list" },
            { "gR",         function() require("trouble").toggle("lsp_references") end,        desc = "Trouble goto references" },
        },
    },
}

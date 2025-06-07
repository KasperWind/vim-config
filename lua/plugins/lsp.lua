local servers_to_install = {
    'lua_ls',
    -- "rust_analyzer",
    -- "taplo",
    'clangd',
    -- "asm_lsp",
    -- "cmake",
    -- 'ts_ls',
    -- "svelte",
    -- "tailwindcss",
    -- "cssls",
    -- "html",
    -- "jsonls",
    -- "yamlls",
    -- "lemminx",
    -- "pyright",
    -- "bashls",
    -- "gopls",
    -- "hls",
    -- "ocamllsp",
    -- "sqlls",
    -- "zls",
    -- "ols"
    -- "omnisharp",
}
return
{
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim',    opts = {} },
        'saghen/blink.cmp',
    },
    config = function()
        local handlers = require('lsp.handlers')

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('wind-lsp-attach', { clear = true }),
            callback = handlers.callback
        })

        local servers = {}
        for _, server in pairs(servers_to_install) do
            local opts = { [server] = {}}
            local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
            if require_ok then
                opts[server] = conf_opts.settings
            end
            servers = vim.tbl_extend('force', servers, opts)
        end
        print(vim.inspect(servers))

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            ensure_installed = {}, -- explicitly set to an empty table (wind populates installs via mason-tool-installer)
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for ts_ls)
                    server.capabilities = vim.tbl_deep_extend('force', {}, handlers.capabilities,
                        server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end
}

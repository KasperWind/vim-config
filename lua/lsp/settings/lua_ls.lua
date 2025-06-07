local m = {}
m.settings = {

    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = {
                globals = { "vim", "neovim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath('config')
                    -- vim.fn.expand('config') .. '/lua',
                },
                checkThirdParty = true,
            },
        },
    },
}
return m

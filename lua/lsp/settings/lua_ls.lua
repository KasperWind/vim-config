local lua = 'Lua'
return {
	settings = {
        [lua] = {
			diagnostics = {
				globals = { "vim", "neovim" },
			},
			workspace = {
				library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.expand('config') .. '/lua',
				},
                checkThirdParty = false,
			},
		},
	},
}

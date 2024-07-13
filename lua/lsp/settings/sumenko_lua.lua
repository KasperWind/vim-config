return {
    on_attach = function (client, _bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end,
	settings = {
        ['Lua'] = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

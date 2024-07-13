return {
    on_attach = function (client, _)
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

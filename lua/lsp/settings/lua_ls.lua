local lua = 'Lua'
return {
	settings = {
        [lua] = {
			diagnostics = {
				globals = { "vim" },
			},
			-- workspace = {
			-- 	library = {
			-- 		-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
			-- 		-- [vim.fn.stdpath("config") .. "/lua"] = true,
			-- 	},
			-- },
		},
	},
}

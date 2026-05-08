vim.api.nvim_create_user_command("OdinBuild", function()
	vim.cmd("enew")
	vim.cmd("term odin build . -debug")
end, {})

vim.api.nvim_create_user_command("OdinRun", function()
	vim.cmd("enew")
	vim.cmd("term odin run . -debug")
end, {})

vim.api.nvim_create_user_command("OdinTest", function()
	vim.cmd("enew")
	vim.cmd("term odin test .")
end, {})

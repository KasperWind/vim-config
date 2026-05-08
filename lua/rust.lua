vim.api.nvim_create_user_command("CargoBuild", function()
	vim.cmd("enew")
	vim.cmd("term cargo build")
end, {})

vim.api.nvim_create_user_command("CargoRun", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	local dir = vim.fs.dirname(filepath)
	local pos = string.len(dir) - string.find(string.reverse(dir), "/") + 2
	local current = string.sub(dir, pos)
	if current == "bin" then
		local file = vim.fs.basename(filepath)
		pos = string.find(file, "%.") - 1
		local mod_name = string.sub(file, 0, pos)
		vim.cmd("enew")
		vim.cmd("term cargo run --bin " .. mod_name)
	else
		vim.cmd("enew")
		vim.cmd("term cargo run")
	end
end, {})

vim.api.nvim_create_user_command("CargoTestPrint", function()
	vim.cmd("enew")
	vim.cmd("term cargo test -- --test-threads=1 --no-capture")
end, {})

vim.api.nvim_create_user_command("CargoTest", function()
	vim.cmd("enew")
	vim.cmd("term cargo test")
end, {})

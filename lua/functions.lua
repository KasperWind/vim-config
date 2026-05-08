-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

local m = {}

local wk = require("which-key")

-- Copy Full File-Path
wk.add({
	{ "<leader>p", group = "Various" },
})

--- Puts the full path in the clip board and prints it out
m.copy_full_path = function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end
vim.keymap.set("n", "<leader>pa", m.copy_full_path, { desc = "Copy full file path" })

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- get messages in a new buffer
m.show_messages_in_buffer = function()
	-- Get messages using vim.fn.execute
	local messages = vim.fn.execute("messages")

	-- Create a new scratch buffer
	vim.cmd("enew")
	local buf = vim.api.nvim_get_current_buf()

	-- Set buffer options (make it a scratch buffer)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false

	-- Put the messages in the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, "\n"))
end

vim.keymap.set(
	"n",
	"<leader>pm",
	m.show_messages_in_buffer,
	{ desc = "Open a new buffer in the current window with the messages" }
)

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

local function append_slash(path)
	if path:sub(-1) == "/" then
		return path
	else
		return path .. "/"
	end
end

--- Prompts the user to select a file using fzf-lua and passes the result to a callback.
---
--- This function opens the fzf-lua file picker (`require('fzf-lua').files`) and calls
--- the given `callback` function with the selected file path as a string.
---
--- ## Usage
--- ```lua
--- local path = vim.fn.expand('%:p:h') .. '/test'
--- find_fzf_file(path, 'dll to search for', 'dll', function (file)
---     print('callback called')
---     print(file)
--- end)
--- ```
---
--- @param cwd string The directory to base the search from.string.sub(selected[1], loc)
--- @param prompt string The prompt showed for the search
--- @param extension string? Extension to search for or nil
--- @param callback fun(filepath: string) Callback function that receives the selected file path.
---        The filepath is a string representing the selected file. If the user cancels,
---        the callback may not be called.
local function find_fzf_file(cwd, prompt, extension, callback)
	local ext = ""
	if extension and extension ~= "" then
		ext = "--type f --extension " .. extension
	end
	require("fzf-lua").files({
		promtp = prompt .. "> ",
		cwd = cwd,
		file_icons = false,
		git_icons = false,
		fd_opts = ext,
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					callback(append_slash(cwd) .. selected[1])
				end
			end,
		},
	})
end

--- Prompts the user to select a file using fzf-lua and passes the result back.
--- @param cwd string The directory to base the search from.string.sub(selected[1], loc)
--- @param prompt string The prompt showed for the search
--- @param extension string? Extension to search for or nil
--- @return string? The absolute path and file name
local function find_file(cwd, prompt, extension)
	local co = coroutine.running()
	if not co then
		error("Must be run in a coroutine")
	end

	local ext = ""
	if extension and extension ~= "" then
		ext = "--type f --extension " .. extension
	end
	require("fzf-lua").files({
		promtp = prompt .. "> ",
		cwd = cwd,
		file_icons = false,
		git_icons = false,
		fd_opts = ext,
		actions = {
			["default"] = function(selected)
				if selected and selected[1] then
					coroutine.resume(co, append_slash(cwd) .. selected[1])
				else
					coroutine.resume(co, nil)
				end
			end,
		},
	})

	return coroutine.yield()
end

local function client_supports_method(client_, method, buf_nr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client_:supports_method(method, buf_nr)
	else
		return client_.supports_method(method, { bufnr = buf_nr })
	end
end

local function toggle_inlay(buf_nr)
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf_nr }))
end

--- Converts the input to a hex formattet string
--- `#xxxxxx`
--- @param n integer value to convert to a hex string
local function to_hex(n)
	if not n then
		return nil
	end
	return string.format("#%06x", n)
end

m.is_windows = vim.loop.os_uname().sysname == "Windows_NT"
m.is_mac = vim.loop.os_uname().sysname == "Darwin"
m.is_linux = not m.is_windows and not m.is_mac

m.find_fzf_file = find_fzf_file
m.find_file = find_file
m.client_supports_method = client_supports_method
m.toggle_inlay = toggle_inlay
m.to_hex = to_hex
m.append_slash = append_slash

return m

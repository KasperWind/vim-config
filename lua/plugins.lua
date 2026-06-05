-- ============================================================================
-- Plugins setup
-- ============================================================================

-- Treesitter
local ensure_installed = {
	"yuck",
	"rust",
	"zig",
	"ini",
	"bash",
	"html",
	"css",
	"markdown",
	"hyprlang",
	"c_sharp",
	"fsharp",
	"c",
	"fish",
	"javascript",
	"jsdoc",
	"jsx",
	"typescript",
	"tsx",
}

local patterns = {
	"lua",
	"rs",
	"yuck",
	"zig",
	"sh",
	"bash",
	"html",
	"md",
	"css",
	"cs",
}

patterns = vim.list_extend(patterns, ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	pattern = patterns,
	callback = function()
		vim.treesitter.start()
	end,
})

local treesitter = require("nvim-treesitter")
treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})
treesitter.install(ensure_installed)

-- fzf lua
local wk = require("which-key")
wk.add({
	{ "<leader>s", group = "FZF lua search" },
})
local fzf_lua = require("fzf-lua")
fzf_lua.setup({
	files = {
		cmd = 'rg --files --glob "!*.git" --glob "!AppData" --glob "!.nuget" --glob "!.dotnet" --glob "!node_modules"',
	},
})
vim.keymap.set("n", "<leader>sf", function()
	fzf_lua.files({ resume = false })
end, { desc = "Search for file in workspace" })
vim.keymap.set("n", "<leader>sr", function()
	fzf_lua.git_files({ resume = false })
end, { desc = "Search for file in repository" })
vim.keymap.set("n", "<leader>sg", function()
	fzf_lua.live_grep()
end, { desc = "Live grep workspace" })
vim.keymap.set("n", "<leader>sb", function()
	fzf_lua.grep_curbuf()
end, { desc = "Grep current buffer" })
vim.keymap.set("n", "<leader>sm", function()
	fzf_lua.manpages()
end, { desc = "Search man pages" })
vim.keymap.set("n", "<leader><leader>s", function()
	fzf_lua.buffers()
end, { desc = "Search open buffers" })

fzf_lua.register_ui_select()

local cm = require("colorful-menu")

-- blink
require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	signature = { enabled = true },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 50,
			window = { border = "rounded" },
		},
		menu = {
			border = "rounded",
			draw = {
				treesitter = { "lsp" },
				components = {
					label = {
						text = function(ctx)
							return cm.blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return cm.blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},
})

-- neogit
wk.add({ { "<leader>g", group = "Git integrated functions" } })

local neogit = require("neogit")
vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Git status view" })

-- todo comments
require("todo-comments").setup({})
local todo = require("todo-comments.fzf")
vim.keymap.set("n", "<leader>st", todo.todo, { desc = "Search todo's" })

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon add current buffer" })
vim.keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon add current buffer" })
vim.keymap.set("n", "<A-h>", function()
	harpoon:list():select(1)
end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-j>", function()
	harpoon:list():select(2)
end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-k>", function()
	harpoon:list():select(3)
end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-l>", function()
	harpoon:list():select(4)
end, { desc = "Opens file 1 in harpoon list" })
vim.keymap.set("n", "<A-p>", function()
	harpoon:list():prev()
end, { desc = "Harpoon previuos" })
vim.keymap.set("n", "<A-n>", function()
	harpoon:list():next()
end, { desc = "Harpoon next" })

-- GutterMarks
require("guttermarks").setup({})

-- oil
require("oil").setup({
	keymaps = {
		["<C-l>"] = false,
		["<C-h>"] = false,
		["<C-r>"] = "actions.refresh",
	},
})
local oil = require("oil")
local open_split = function()
	oil.open()
	local start = vim.api.nvim_get_current_win()
	vim.cmd("vsplit")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
	local pwd = vim.fn.getcwd()
	oil.open(pwd)
	vim.api.nvim_set_current_win(start)
end
wk.add({ { "<leader>n", group = "File manager" } })
vim.keymap.set("n", "<leader>ns", open_split, { desc = "Oil open split" })
vim.keymap.set("v", "<leader>ns", open_split, { desc = "Oil open split" })
vim.keymap.set("n", "<leader>nn", oil.open, { desc = "Oil open" })
vim.keymap.set("v", "<leader>nn", oil.open, { desc = "Oil open" })

-- nvim-tree
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>nN", ":NvimTreeToggle<cr>", { desc = "Nvim-tree toggle" })
vim.keymap.set("v", "<leader>nN", ":NvimTreeToggle<cr>", { desc = "Nvim-tree toggle" })

-- Status line, lua line
require("lualine_setup")

-- Conform.nvim formatter setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier", stop_after_first = true },
		markdown = { "prettier", stop_after_first = true },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		-- rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
	},
})

local conform = require("conform")
vim.keymap.set("n", "<leader>f", conform.format, { desc = "Formats the current buffer" })
vim.keymap.set("v", "<leader>f", conform.format, { desc = "Formats the current buffer" })

-- Trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr> ",              { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr> ",                           { desc = "Global Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr> ",                   { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr> ",    { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr> ",                               { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr> ",                                { desc = "Quickfix List (Trouble)" })

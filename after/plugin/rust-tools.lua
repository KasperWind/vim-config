local rust_tools_status_ok, rt = pcall(require, "rust-tools")
if not rust_tools_status_ok then
  return
end

local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/'
local codelldb_path = extension_path .. 'codelldb'

local function lsp_keymaps(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	local keymap = vim.keymap.set
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gI", vim.lsp.buf.implementation, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "gl", vim.diagnostic.open_float, opts)
	keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap("n", "<leader>lI", "<cmd>LspInstall<cr>", opts)
    keymap("n", "<Leader>la", rt.code_action_group.code_action_group, opts)
    keymap("n", "<C-space>", rt.hover_actions.hover_actions, opts)
	keymap("n", "<leader>lj", function() vim.diagnostic.goto_next({buffer=0}) end, opts)
	keymap("n", "<leader>lk", function() vim.diagnostic.goto_prev({buffer=0}) end, opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
	keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, opts)
end

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools.executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
    on_attach = lsp_keymaps
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter =  {
      type = "server",
      port = "13000",
      host = "127.0.0.1",
      executable = {
        command = codelldb_path,
        args = { "--port", "13000" },
      }
    }
  }
}

rt.setup(opts)

local tree_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not tree_status_ok then
  print("treesitter not loaded")
  return
end
-- See `:help nvim-treesitter`
treesitter.setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 
        'typescript', 'tsx', 'dart', 'haskell', 'bash', 'dockerfile', 'cmake', 'yaml', 'toml', 'svelte', 'proto', 'sql', 'swift', 
        'html', 'htmldjango' },

  highlight = { enable = true },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  indent = { enable = true, disable = { 'python' } },
  	autopairs = {
		enable = true,
	},
}
local tree_context_status_ok, context = pcall(require, "treesitter-context")
if not tree_context_status_ok then
  print("treesitter context not loaded")
  return
end

context.setup()

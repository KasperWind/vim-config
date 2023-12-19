-- local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", {clear = true})
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "swift" },
--     group = swift_lsp,
--     callback = function ()
--         local root_dir = vim.fs.dirname(vim.fs.find({
--             "Package.swift",
--             ".git",
--         }, { upward = true})[1])
--         local client = vim.lsp.start({
--             name = "sourcekit-lsp",
--             cmd = { "sourcekit-lsp"},
--             root_dir = root_dir,
--         })
--         if client then
--             vim.lsp.buf_attach_client(0, client)
--         else
--             print("failed to start swift_lsp")
--         end
--     end
-- })

require'lspconfig'.sourcekit.setup{
    cmd = {'/home/kasperw/.swift/usr/bin/swift'}
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

local server = 'sourcekit'
opts = {
    on_attach = require("custom.lsp.handlers").on_attach,
    capabilities = require("custom.lsp.handlers").capabilities,
}

server = vim.split(server, "@")[1]

local require_ok, conf_opts = pcall(require, "custom.lsp.settings." .. server)
if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
end

lspconfig[server].setup(opts)

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "after.plugin.lsp.mason"
require("after.plugin.lsp.handlers").setup()
require "after.plugin.lsp.null-ls"

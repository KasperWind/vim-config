local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers = require "custom.lsp.handlers"
handlers.setup()

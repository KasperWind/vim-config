local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- local client = vim.lsp.start_client({
--     name = "testlsp_readme",
--     cmd = { "/home/kasperw/repos/lsp/test-lsp/target/debug/test-lsp" },
--     on_attach = require('lsp.handlers').on_attach,
--
-- })
--
-- if not client then
--     vim.notify_once("client lsp not loaded")
--     return {}
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function ()
--         vim.lsp.buf_attach_client(0, client)
--     end
-- })

local handlers = require('lsp.handlers')
return {
    on_attach = function (client, bufnr)
        local opts = function (desc)
            return { desc=desc, noremap = true, silent = true }
        end
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bb", "<cmd>make<CR>", opts("dotnet build"))
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>br", "<cmd>!dotnet run<CR>", opts("dotnet run"))
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>br", "<cmd>!dotnet run<CR>", opts("dotnet run"))

        handlers.on_attach_required(client, bufnr)

        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<CR>", opts("LSP: go to definition"))
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<CR>", opts("LSP: go to declaration"))
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<CR>", opts("LSP: show references"))
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<CR>", opts("LSP: go to implementation"))
    end,
}

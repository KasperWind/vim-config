local m = {}
m.on_attach = function(event)
    local bufnr = event.buf
    local opts = function(desc)
        return { desc = desc, noremap = true, silent = true }
    end
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bb", "<cmd>make build<CR>", opts("Cargo build"))
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>br", "<cmd>make run<CR>", opts("Cargo run"))
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bt", "<cmd>make test<CR>", opts("Cargo test"))

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local path = client.workspace_folders[1].name .. "/.cargo/config.toml"
    local filereadable = vim.fn.filereadable(path)
    if filereadable == 1 then
        local _ = vim.fn.readfile(path)
        client.config.settings["rust-analyzer"].cargo.target = "armv7a-none-eabi"
        client.config.settings["rust-analyzer"].check.allTargets = false
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end

end
m.settings = {
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                -- target = "thumbv7em-none-eabihf",
                -- target = "armv7a-none-eabi",
                buildScripts = {
                    enable = true,
                },
            },
            check = {
                -- allTargets = false,
            },
            procMacro = {
                enable = true,
            },
        },
    },
}
return m

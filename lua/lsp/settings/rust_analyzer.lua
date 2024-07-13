local handlers = require('lsp.handlers')
return {
    on_init = function (client)
        local path = client.workspace_folders[1].name


        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
    end,
    on_attach = function (client, bufnr)
        local opts = function (desc)
            return { desc=desc, noremap = true, silent = true }
        end
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bb", "<cmd>make build<CR>", opts("Cargo Build"))
        handlers.on_attach_required(client, bufnr)
    end,
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
                buildScripts = {
                    enable = true,
                },
            },
            check = {
                allTargets = true,
            },
            procMacro = {
                enable = true,
            },
        },
	},
}

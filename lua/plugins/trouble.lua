return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            modes = {
                diagnostics_workspace = {
                    mode = "diagnostics",
                    filter = {
                        any = {
                            buf = 0,
                            {
                                severity = vim.diagnostic.severity.WARN,
                                function(item)
                                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                                end
                            }
                        }
                    }
                }
            }
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "Toggle (Trouble)",
            },
            {
                "<leader>xw",
                "<cmd>Trouble diagnostics_workspace toggle focus=true<cr>",
                desc = "Workspace diagnostics (Trouble)",
            },
            {
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
                desc = "Document diagnostics (Trouble)",
            },
            {
                "<leader>xq",
                "<cmd>Trouble quickfix toggle focus=true<cr>",
                desc = "To quickfix list (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble loclist toggle focus=true<cr>",
                desc = "To location list (Trouble)",
            },
            {
                "<leader>xr",
                "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false win.position=bottom<cr>",
                desc = "Symbols (Trouble)",
            },
        },
    },
}

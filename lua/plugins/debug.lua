local conditional_breakpoint = function()
    local condition = vim.fn.input('Enter breakpoint condition: ')
    require('dap').set_breakpoint(condition)
end

local find_file = function(header, cwd, extension)
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local co = coroutine.running()
    if not co then
        error("Must be run in a coroutine")
    end

    local selected_file = nil

    builtin.find_files({
        prompt_title = header,
        find_command = { "fd", "--no-ignore", "--hidden", "--strip-cwd-prefix", "--extension", extension },
        cwd = cwd,

        attach_mappings = function(promt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(promt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    selected_file = selection.path:gsub("//+", "/"):gsub("\\\\+", "\\")
                end
                coroutine.resume(co)
            end)
            return true
        end
    })

    coroutine.yield()
    return selected_file
end
return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            vim.fn.sign_define('DapBreakpoint', {text='', texthl='DiagnosticSignError', linehl='', numhl=''})
            vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DiagnosticSignError', linehl='', numhl=''})
            vim.fn.sign_define('DapLogPoint', {text='', texthl='DiagnosticSignError', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='', texthl='DiagnosticSignHint', linehl='', numhl=''})
            vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DiagnosticSignError', linehl='', numhl=''})

            dap.adapters.coreclr = {
                type = 'executable',
                command = 'C:\\Users\\extkawi\\Downloads\\netcoredbg-win64\\netcoredbg\\netcoredbg.exe',
                args = { '--interpreter=vscode' }
            }
            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return find_file('Path to dll to debug', vim.fn.getcwd() .. '/bin/', 'dll')
                    end,
                },
            }
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Debug: Set breakpoint" },
            { "<leader>dB", conditional_breakpoint,         desc = "Debug: Set conditional breakpoint" },
            { "<leader>dc", "<cmd>DapContinue<cr>",         desc = "Debug: Run/continue" },
            { "ds",         "<cmd>DapStepOver<cr>",         desc = "Debug: Step over" },
            { "<leader>ds", "<cmd>DapStepInto<cr>",         desc = "Debug: Step into" },
            { "<leader>do", "<cmd>DapStepOut<cr>",          desc = "Debug: Step out" },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require('dapui').setup({
                layouts = { {
                    elements = { {
                        id = "scopes",
                        size = 0.25
                    }, {
                        id = "breakpoints",
                        size = 0.25
                    }, {
                        id = "stacks",
                        size = 0.25
                    }, {
                        id = "watches",
                        size = 0.25
                    } },
                    position = "left",
                    size = 80
                }, {
                    elements = { {
                        id = "repl",
                        size = 0.5
                    }, {
                        id = "console",
                        size = 0.5
                    } },
                    position = "bottom",
                    size = 10
                } },

            })
        end
    }
}

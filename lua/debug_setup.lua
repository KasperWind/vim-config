-- ============================================================================
-- Debuug setup
-- ============================================================================

local dap = require('dap')
local f = require('functions')

-- dap ui
local dapui = require('dapui')
dapui.setup({
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

-- Options

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })

-- keymaps
local conditional_breakpoint = function()
    local condition = vim.fn.input('Enter breakpoint condition: ')
    dap.set_breakpoint(condition)
end
vim.keymap.set('n', "<leader>bB", "<cmd>DapToggleBreakpoint<cr>", { desc = "Debug: Set breakpoint" })
vim.keymap.set('n', "<leader>bC", conditional_breakpoint, { desc = "Debug: Set conditional breakpoint" })
vim.keymap.set('n', "<leader>bc", "<cmd>DapContinue<cr>", { desc = "Debug: Run/continue" })
vim.keymap.set('n', "bs", "<cmd>DapStepOver<cr>", { desc = "Debug: Step over" })
vim.keymap.set('n', "<leader>bs", "<cmd>DapStepInto<cr>", { desc = "Debug: Step into" })
vim.keymap.set('n', "<leader>bo", "<cmd>DapStepOut<cr>", { desc = "Debug: Step out" })
vim.keymap.set('n', "<leader>bq", dapui.close, { desc = "Debug: Terminate" })

-- Debuggers
-- CSharp
dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            f.find_file(vim.fn.getcwd() .. '/bin/Debug/', 'Path to file to debug', nil)
        end,
    },
}

-- gdb
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            local p = f.find_file(vim.fn.getcwd() .. '/bin/', 'Path to file to debug',  nil)
            return p
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return f.find_file(vim.fn.getcwd() .. '/bin/', 'Path to executable to debug', nil)
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
            return f.find_file(vim.fn.getcwd() .. '/bin/', 'Path to executable to debug', nil)
        end,
        cwd = '${workspaceFolder}'
    },
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            local p = f.find_file(vim.fn.getcwd() .. '/target/debug', 'Path to file to debug',  nil)
            return p
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return f.find_file(vim.fn.getcwd() .. '/target/debug/', 'Path to executable to debug', nil)
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
            return f.find_file(vim.fn.getcwd() .. '/target/debug/', 'Path to executable to debug', nil)
        end,
        cwd = '${workspaceFolder}'
    },
}

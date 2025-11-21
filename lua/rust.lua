vim.api.nvim_create_user_command('CargoBuild', function()
    vim.cmd('enew')
    vim.cmd('term cargo build')
end, {})

vim.api.nvim_create_user_command('CargoRun', function()
    vim.cmd('enew')
    vim.cmd('term cargo run')
end, {})

vim.api.nvim_create_user_command('CargoTest', function()
    vim.cmd('enew')
    vim.cmd('term cargo test -- --no-capture')
end, {})


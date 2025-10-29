vim.api.nvim_create_user_command('OmniSharpBuild', function()
    vim.cmd('enew')
    vim.cmd('term dotnet build')
end, {})

vim.api.nvim_create_user_command('OmniSharpRun', function()
    vim.cmd('enew')
    vim.cmd('term dotnet run')
end, {})

vim.api.nvim_create_user_command('OmniSharpTest', function()
    vim.cmd('enew')
    vim.cmd('term dotnet test')
end, {})


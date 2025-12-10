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

vim.api.nvim_create_user_command('OmniSharpCodeViewToggle', function()
    local function ends_with(str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end
    local filepath = vim.api.nvim_buf_get_name(0)
    if ends_with(filepath, ".xaml") then
        vim.api.nvim_command("edit " .. filepath .. ".cs")
    elseif ends_with(filepath, ".xaml.cs") then
        vim.api.nvim_command("edit " .. filepath:sub(1, #filepath - 3))
    end
end, {})



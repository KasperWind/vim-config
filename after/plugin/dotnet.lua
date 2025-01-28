vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
        callback = function()
        vim.cmd('compiler dotnet')
    end,
})

local group = vim.api.nvim_create_augroup("WindGoLang", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
    desc = "Go lang setting make cmd",
    group = group,
    pattern = "*.go",
    callback = function ()
        vim.cmd [[
            compiler go
        ]]
    end
})


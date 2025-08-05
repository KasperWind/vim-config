-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================


local wk = require('which-key')

-- Copy Full File-Path
wk.add({
    { "<leader>p", group = "Various" },
})
vim.keymap.set("n", "<leader>pa", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end, { desc = 'Copy full file path' })

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- get messages in a new buffer
local show_messages_in_buffer = function()
    -- Get messages using vim.fn.execute
    local messages = vim.fn.execute('messages')

    -- Create a new scratch buffer
    vim.cmd('enew')
    local buf = vim.api.nvim_get_current_buf()

    -- Set buffer options (make it a scratch buffer)
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].swapfile = false

    -- Put the messages in the buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(messages, '\n'))
end
vim.keymap.set("n", "<leader>pm", show_messages_in_buffer, { desc = 'Open a new buffer in the current window with the messages' })

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

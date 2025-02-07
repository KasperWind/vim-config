local function string_to_list(input, delimiter)
    delimiter = delimiter or ","
    local result = {}
    for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

function SearchManPages(index)
    -- Use the index if provided, otherwise search all sections
    index = index or ""
    if index == "" then
        index = "1,2,3,4,5,6,7"
    end
    local indexes = string_to_list(index, ",")

    require('telescope.builtin').man_pages({
        sections = indexes
    })
end

return {
    {
        'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
    },
    {
        'nvim-telescope/telescope-media-files.nvim'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        config = function()
            -- Enable telescope fzf native, if installed

            -- See `:help telescope.builtin`
            vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
                { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
                { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', require('telescope.builtin').git_files, { desc = '[S]earch by git [R]epo' })
            vim.keymap.set('n', '<leader>sm',
                function()
                    local user_input = vim.fn.input("Enter sections (1,7): ")

                    SearchManPages(user_input)
                end, { desc = '[S]earch by [M]an pages' })

            local actions = require "telescope.actions"

            require("telescope").setup {
                defaults = {

                    prompt_prefix = " ",
                    selection_caret = " ",
                    path_display = { "smart" },
                    file_ignore_patterns = { ".git/", "node_modules", "target", "build", "bin", "obj" },

                },
                extensions = {
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = { "png", "webp", "jpg", "jpeg" },
                        -- find command (defaults to `fd`)
                        find_cmd = "fd"
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                },
            }
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'media_files')
            pcall(require('telescope').load_extension, 'oil')
        end,
    },
}

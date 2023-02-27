local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("nvim tree not found")
  return
end

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if data.file == "" then
    return
  end

  if directory then
    vim.cmd.cd(data.file)
  end

  require("nvim-tree.api").tree.open()

  if not directory then
    local windows = vim.api.nvim_list_wins()
    if #windows > 1 then
      vim.api.nvim_set_current_win(windows[2])
    end
  end
end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
       { key = { "l", "<CR>", "o" }, action = "edit" },
       { key = "h", action = "close_node" },
      { key = "v", action = "vsplit" },
      },
    },
  },
}

-- auto startup
vim.api.nvim_create_autocmd({"VimEnter"}, { callback = open_nvim_tree})

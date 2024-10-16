require("neo-tree").setup({
  window = {
    position = "float"
  },
  buffers = {
    leave_dirs_open = true,
    follow_current_file = {
      enabled = true,
    },
  },
  filesystem = {
    use_libuv_file_watcher = false,
    follow_current_file = {
      enabled = true,
    },
    filtered_items = {
      hide_gitignored = false,
      hide_dotfiles = false,
      hide_by_name = {
        ".idea", ".git"
      }
    }
  }
})

vim.keymap.set("n", "⌘e", ":Neotree float reveal_force_cwd<cr>", { silent = true })
vim.keymap.set("n", "<leader>e", ":Neotree float reveal_force_cwd<cr>", { silent = true })

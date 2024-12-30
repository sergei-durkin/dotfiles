require("telescope").load_extension("lazygit")
require("telescope").load_extension("refactoring")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

vim.keymap.set({"n", "x"}, "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end)

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup {
  defaults = {
    layout_config = { flex = { flip_columns = 120 } },
    pickers = {
      find_files = {
        theme = "dropdown",
      }
    },
    mappings = {
      n = { ["⌃t"] = open_with_trouble },
      i = {
        ["⌃t"] = open_with_trouble,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-d>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default + actions.center,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Enable telescope rest, if installed
pcall(require("telescope").load_extension, "rest")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>rf", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "⌘u", function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = true,
  })
end, { desc = "[/] Fuzzily search in current buffer]" })
vim.keymap.set("n", "⌘U", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sS", builtin.git_status, { desc = "" })
vim.keymap.set("n", "<leader>sr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", silent)
vim.keymap.set("n", "<leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", silent)
vim.keymap.set("n", "<leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)

vim.api.nvim_set_keymap("n", "<leader>st", ":TodoTelescope<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader><tab>", "<CMD>lua require('telescope.builtin').commands()<CR>", {noremap=false})

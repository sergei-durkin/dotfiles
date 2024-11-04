require('telescope').load_extension('lazygit')
require("telescope").load_extension("refactoring")

vim.keymap.set({"n", "x"}, "<leader>rr", function() require('telescope').extensions.refactoring.refactors() end)

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_config = { flex = { flip_columns = 120 } },
    pickers = {
      find_files = {
        theme = "dropdown",
      }
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
        ["<C-d>"] = require('telescope.actions').move_selection_previous,
        ["<CR>"] = require('telescope.actions').select_default + require('telescope.actions').center,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>rf', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '⌘u', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = true,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '⌘U', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sS', require('telescope.builtin').git_status, { desc = '' })
vim.keymap.set("n", "<leader>sr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", silent)
vim.keymap.set("n", "<leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", silent)
vim.keymap.set("n", "<leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)

vim.api.nvim_set_keymap("n", "<leader>st", ":TodoTelescope<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", {noremap=false})

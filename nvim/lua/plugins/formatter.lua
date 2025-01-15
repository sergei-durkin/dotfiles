require("sql-formatter").setup({
  go = {
    dialect = "postgresql",
    tabWidth = 1,
    useTabs = true,
    keywordCase = "upper",
  },
  php = {
    dialect = "postgresql",
    tabWidth = 4,
    useTabs = false,
    keywordCase = "upper",
  },
})

vim.api.nvim_set_keymap("n", "<leader>fs", ":FormatSql<CR>", { noremap = true, silent = true })

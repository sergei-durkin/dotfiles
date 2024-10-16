-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    if vim.g.savesession then
      vim.api.nvim_command("mks!")
    end
  end
})

vim.api.nvim_set_hl(0, "IlluminatedWord", { bg = "#4c415c" })
vim.api.nvim_set_hl(0, "IlluminatedCurWord", { bg = "#4c415c" })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4c415c" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4c415c" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4c415c" })

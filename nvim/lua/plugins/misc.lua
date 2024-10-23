-- Enable Comment.nvim
require('Comment').setup()

-- Go
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup({
  run_in_floaterm = true,
  icons = false,
  floaterm = {
    position = "bottom",
    width = 0.3,
    height = 0.3,
  },
})

require("auto-save").setup()

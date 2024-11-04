require("auto-session").setup({
  enabled = true,
  auto_save = true,
  auto_restore = true,
  auto_create = true,
  suppressed_dirs = { '~/', '~/p', '~/Downloads', '/', '~/sandbox', '~/ssh'},
  allowed_dirs = { '~/p/*', '~/sandbox/*', '~/.config', '~/project/*', '~/dotfiles' },
  session_lens = {
    load_on_setup = true,
  },
})

vim.api.nvim_set_keymap("n", "⌘p", ":SessionSearch<CR>", {noremap=true})

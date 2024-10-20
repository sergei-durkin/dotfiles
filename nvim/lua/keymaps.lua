vim.api.nvim_set_keymap("i", "eu", "<Esc>", { noremap = false })

-- twilight
vim.api.nvim_set_keymap("n", "TW", ":Twilight<enter>", { noremap = false })

-- buffers
vim.api.nvim_set_keymap("n", "<C-d>", ":bprev<enter>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":bnext<enter>", { noremap = true })
vim.api.nvim_set_keymap("n", "⌃⌫", ":bdelete<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "⌘,", ":bdelete<enter>", { noremap = false })

-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "E", "$", { noremap = false })
vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", { noremap = true })

-- splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })
vim.keymap.set('n', '<space><space>', "<cmd>set nohlsearch<CR>")

-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("i", "<F2>", "<ESC>:w!<CR>", { silent = true })
vim.keymap.set({"n","v"}, "`", ":", { noremap = true })
vim.keymap.set({"n","v"}, "<F2>", ":w!<CR>", { silent = true })
-- vim.keymap.set({"n","v"}, "q", "<ESC>:GoTermClose<CR>", { silent = true })

-- Keymaps for dvorak users
vim.opt.langmap = "dh,hj,tk,nl,kd,jt,DH,HJ,TK,NL,KD,JT"

-- Keymaps for go
vim.keymap.set("n", "<leader>ll", "<cmd>GoIfErr<cr>", { silent = true, noremap = false })

-- Keymaps for scrolling
vim.keymap.set({"n", "v"}, "⌃j", "20jzz", { noremap = true })
vim.keymap.set({"n", "v"}, "⌃k", "20kzz", { noremap = true })

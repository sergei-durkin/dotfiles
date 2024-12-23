vim.api.nvim_set_keymap("i", "eu", "<Esc>", { noremap = false })

-- twilight
vim.api.nvim_set_keymap("n", "TW", ":Twilight<enter>", { noremap = false })

-- buffers
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
vim.keymap.set("n", "<space>qq", ":q<CR>", { silent = true, noremap = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("i", "<F2>", "<ESC>:w!<CR>", { silent = true })
vim.keymap.set({"n","v"}, "`", ":", { noremap = true })
vim.keymap.set({"n","v"}, "<F2>", ":w!<CR>", { silent = true })

-- Keymaps for kinesis
vim.keymap.set("i", "<PageDown>", "<ESC>:w!<CR>", { silent = true })
vim.keymap.set({"n","v"}, "|", ":", { noremap = true })
vim.keymap.set({"n","v"}, "<PageDown>", ":w!<CR>", { silent = true })

-- Keymaps for dvorak users
vim.opt.langmap = "tj,dh,hj,tk,nl,ln,kd,jt,DH,HJ,TK,NL,LN,KD,JT"

-- Keymaps for scrolling
vim.keymap.set({"n", "v"}, "⌃j", "20jzz", { noremap = true })
vim.keymap.set({"n", "v"}, "⌃k", "20kzz", { noremap = true })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })

vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })

vim.keymap.set("n", "<space>cf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>", { noremap = true })

vim.keymap.set({"n", "v"}, "<Space>p", "\"_dP", { noremap = true })

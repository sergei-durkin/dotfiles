vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap("i", "eu", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("i", "ва", "<Esc>", { noremap = false })

-- buffers
vim.api.nvim_set_keymap("n", "⌃⌫", ":bdelete!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "⌘,", ":bdelete!<enter>", { noremap = false })

-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "E", "$", { noremap = false })
vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })

-- splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })
vim.keymap.set("n", "<space><space>", "<cmd>set nohlsearch<CR><cmd>noh<CR>")

-- Quicker close split
vim.keymap.set("n", "<space>qq", ":q<CR>", { silent = true, noremap = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("i", "<F2>", "<ESC>:w!<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "`", ":", { noremap = true })
vim.keymap.set({ "n", "v" }, "<F2>", ":w!<CR>", { silent = true })

-- Keymaps for kinesis
vim.keymap.set("i", "<PageDown>", "<ESC>:w!<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "|", ":", { noremap = true })
vim.keymap.set({ "n", "v" }, "<PageDown>", ":w!<CR>", { silent = true })

-- Keymaps for dvorak users
vim.opt.langmap =
    "tj,dh,hj,tk,nl,ln,kd,jt,DH,HJ,TK,NL,LN,KD,JT,й\\;,Й\\:,ц\\,Ц\\<,у\\.,У\\>,кp,КP,еy,ЕY,нf,НF,гg,ГG,шc,ШC,щr,ЩR,зn,ЗN,фa,ФA,ыo,ЫO,вe,ВE,аu,АU,пi,ПI,рh,РH,оj,ОJ,лk,ЛK,дl,ДL,жs,ЖS,я',Я\",чq,ЧQ,сt,СT,мd,МD,иx,ИX,тb,ТB,ьm,ЬM,бw,БW,юv,ЮV"

vim.keymap.set({ "i" }, "⌃j", "<down>")
vim.keymap.set({ "i" }, "⌃h", "<left>")
vim.keymap.set({ "i" }, "⌃k", "<up>")
vim.keymap.set({ "i" }, "⌃l", "<right>")

-- Keymaps for scrolling
vim.keymap.set({ "n", "v" }, "⌃j", "20jzz", { noremap = true })
vim.keymap.set({ "n", "v" }, "⌃k", "20kzz", { noremap = true })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })

vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })

vim.keymap.set("n", "<space>cf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>", { noremap = true })

vim.keymap.set({ "n", "v" }, "<Space>p", '"_dP', { noremap = true })

vim.keymap.set({ "n" }, "-", "<CMD>lua require('oil').toggle_float(\".\")<CR>", { desc = "Open parent directory" })

-- Keymaps for moving between splits
vim.keymap.set("n", "⌥h", "<C-W>h", { noremap = true })
vim.keymap.set("n", "⌥j", "<C-W>j", { noremap = true })
vim.keymap.set("n", "⌥k", "<C-W>k", { noremap = true })
vim.keymap.set("n", "⌥l", "<C-W>l", { noremap = true })

-- Keymaps for resizing splits
vim.keymap.set("n", "⌥H", "<C-W><", { noremap = true })
vim.keymap.set("n", "⌥J", "<C-W>,", { noremap = true })
vim.keymap.set("n", "⌥K", "<C-W>.", { noremap = true })
vim.keymap.set("n", "⌥L", "<C-W>>", { noremap = true })

vim.cmd("unmap gra")
vim.cmd("unmap gri")
vim.cmd("unmap grn")
vim.cmd("unmap grr")
vim.cmd("unmap grt")

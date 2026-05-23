-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    pattern = "*",
    callback = function()
        if vim.g.savesession then
            vim.api.nvim_command("mks!")
        end
    end,
})

-- local illuminate_color = "#4c415c"
local illuminate_color = "#323232"

vim.api.nvim_set_hl(0, "IlluminatedWord", { bg = illuminate_color })
vim.api.nvim_set_hl(0, "IlluminatedCurWord", { bg = illuminate_color })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = illuminate_color })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = illuminate_color })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = illuminate_color })

for _, kind in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local name = "DiagnosticUnderline" .. kind
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    hl.underline = false
    hl.undercurl = true
    vim.api.nvim_set_hl(0, name, hl)
end

vim.deprecate = function() end

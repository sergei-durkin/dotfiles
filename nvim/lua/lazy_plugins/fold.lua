return {
    {
        "kevinhwang91/nvim-ufo",
        event = "BufReadPost",
        opts = {
            open_fold_hl_timeout = 400,
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
        },
        init = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        dependencies = {
            "kevinhwang91/promise-async",
        },

        config = function()
            require("ufo").setup({
                provider_selector = function(_, _, _)
                    return { "lsp", "indent" }
                end,
            })

            vim.keymap.set("n", "zK", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end)
        end,
    },
}

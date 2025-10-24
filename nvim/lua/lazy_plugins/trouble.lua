return {
    {
        "folke/trouble.nvim",
        lazy = false,
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true, noremap = true })
            vim.keymap.set(
                "n",
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                { silent = true, noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                { silent = true, noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>xn",
                "<cmd>Trouble loclist toggle<cr>", -- xl in dvorak
                { silent = true, noremap = true }
            )
            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true, noremap = true })
            vim.keymap.set(
                "n",
                "gR",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                { silent = true, noremap = true }
            )

            local signs = {
                Error = " ",
                Warning = " ",
                Hint = " ",
                Information = " ",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}

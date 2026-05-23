return {
    {
        dir = "~/sandbox/sql-formatter.nvim",
        url = "sergei-durkin/sql-formatter.nvim",
        lazy = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "FormatSql",
        keys = {
            { "<leader>fs", "<cmd>FormatSql<CR>", desc = "Format SQL", silent = true },
        },

        config = function()
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
        end,
    },
}

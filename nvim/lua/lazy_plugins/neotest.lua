return {
    {
        "nvim-neotest/neotest",

        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "fredrikaverpil/neotest-golang",
                version = "*",
                dependencies = {
                    "uga-rosa/utf8.nvim",
                },
            },
        },

        keys = {
            { "<space>ra", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
            { "<space>rf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
            { "<space>rA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
            { "<space>rS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
            { "<space>rl", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
            { "<space>rn", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
            { "<space>rs", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
            { "<space>ro", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
            { "<space>rO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
            { "<space>rt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
            { "<space>rd", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
            { "<space>rD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug current file" },
        },

        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-golang")({
                        warn_test_name_dupes = false,
                        runner = "gotestsum",
                        sanitize_output = true,
                        testify_enabled = true,
                        go_test_args = { "-count=1", "-tags=armtracer,integration,wireinject" },
                        go_list_args = { "-tags=armtracer,integration,wireinject" },
                    }),
                },
            })
        end,
    },
}

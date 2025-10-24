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

        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-golang")({
                        runner = "gotestsum",
                        sanitize_output = true,
                        testify_enabled = true,
                        go_test_args = { "-count=1", "-tags=armtracer,integration,wireinject" },
                        go_list_args = { "-tags=armtracer,integration,wireinject" },
                    }),
                },
            })

            vim.keymap.set("n", "<space>ra", function()
                neotest.run.attach()
            end, { desc = "[t]est [a]ttach", noremap = true })
            vim.keymap.set("n", "<space>rf", function()
                neotest.run.run(vim.fn.expand("%"))
            end, { desc = "[t]est run [f]ile", noremap = true })
            vim.keymap.set("n", "<space>rA", function()
                neotest.run.run(vim.uv.cwd())
            end, { desc = "[t]est [A]ll files", noremap = true })
            vim.keymap.set("n", "<space>rS", function()
                neotest.run.run({ suite = true })
            end, { desc = "[t]est [S]uite", noremap = true })
            vim.keymap.set("n", "<space>rl", function()
                neotest.run.run()
            end, { desc = "[t]est [n]earest", noremap = true })
            vim.keymap.set("n", "<space>rn", function()
                neotest.run.run_last()
            end, { desc = "[t]est [l]ast", noremap = true })
            vim.keymap.set("n", "<space>rs", function()
                neotest.summary.toggle()
            end, { desc = "[t]est [s]ummary", noremap = true })
            vim.keymap.set("n", "<space>ro", function()
                neotest.output.open({ enter = true, auto_close = true })
            end, { desc = "[t]est [o]utput", noremap = true })
            vim.keymap.set("n", "<space>rO", function()
                neotest.output_panel.toggle()
            end, { desc = "[t]est [O]utput panel", noremap = true })
            vim.keymap.set("n", "<space>rt", function()
                neotest.run.stop()
            end, { desc = "[t]est [t]erminate", noremap = true })
            vim.keymap.set("n", "<space>rd", function()
                neotest.run.run({ suite = false, strategy = "dap" })
            end, { desc = "Debug nearest test", noremap = true })
            vim.keymap.set("n", "<space>rD", function()
                neotest.run.run({ vim.fn.expand("%"), strategy = "dap" })
            end, { desc = "Debug current file", noremap = true })
        end,
    },
}

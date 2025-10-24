return {
    {
        "mini.ai",

        config = function()
            require("mini.ai").setup()
        end,
    },
    {
        "mini.surround",

        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "mini.jump2d",

        config = function()
            require("mini.jump2d").setup({
                view = {
                    dim = true,
                },
            })

            vim.api.nvim_set_hl(0, "MiniJump2dSpot", { fg = "#f70067", sp = "#f70067", undercurl = true })
            vim.keymap.set(
                "n",
                "<CR>",
                "<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
                { noremap = true, silent = true }
            )
        end,
    },
    {
        "mini.operators",

        config = function()
            require("mini.operators").setup({
                -- Evaluate text and replace with output
                evaluate = {
                    prefix = "<space>g=",

                    -- Function which does the evaluation
                    func = nil,
                },

                -- Exchange text regions
                exchange = {
                    prefix = "<space>gx",

                    -- Whether to reindent new text to match previous indent
                    reindent_linewise = true,
                },

                -- Multiply (duplicate) text
                multiply = {
                    prefix = "<space>gm",

                    -- Function which can modify text before multiplying
                    func = nil,
                },

                -- Replace text with register
                replace = {
                    prefix = "<space>gr",

                    -- Whether to reindent new text to match previous indent
                    reindent_linewise = true,
                },

                -- Sort text
                sort = {
                    prefix = "<space>gs",

                    -- Function which does the sort
                    func = nil,
                },
            })
        end,
    },
}

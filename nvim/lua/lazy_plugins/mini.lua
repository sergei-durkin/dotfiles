return {
    {
        "nvim-mini/mini.files",

        config = function()
            require("mini.files").setup()
            local map_split = function(buf_id, lhs, direction, close_on_file)
                local rhs = function()
                    local new_target_window
                    local cur_target_window = require("mini.files").get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd(direction .. " split")
                            new_target_window = vim.api.nvim_get_current_win()
                        end)
                        require("mini.files").set_target_window(new_target_window)
                        require("mini.files").go_in({ close_on_file = close_on_file })
                    end
                end
                local desc = "Split " .. direction
                if close_on_file then
                    desc = desc .. " and close"
                end
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    map_split(buf_id, "<C-w>s", "belowright horizontal", false)
                    map_split(buf_id, "<C-w>v", "belowright vertical", false)
                    map_split(buf_id, "<C-w>S", "belowright horizontal", true)
                    map_split(buf_id, "<C-w>V", "belowright vertical", true)
                end,
            })
        end,

        keys = {
            {
                "<leader>e",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                    require("mini.files").reveal_cwd()
                end,
                desc = "Open mini.files (current file)",
            },
        },
    },
    {
        "nvim-mini/mini.ai",

        config = function()
            require("mini.ai").setup()
        end,
    },
    {
        "nvim-mini/mini.surround",

        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "nvim-mini/mini.jump2d",

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
        "nvim-mini/mini.operators",

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

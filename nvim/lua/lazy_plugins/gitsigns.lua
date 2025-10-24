return {
    {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "┃" },
                },

                signs_staged = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "┃" },
                },

                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },

                current_line_blame = false,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader>js", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>jr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>jS", gs.stage_buffer)

                    -- Unstage hunk
                    map("n", "<leader>ja", gs.stage_hunk)

                    -- Undo unstage hunk
                    map("n", "<leader>ju", gs.undo_stage_hunk)
                    map("n", "<leader>RB", gs.reset_buffer)
                    map("n", "<leader>pj", gs.preview_hunk)
                    map("n", "<leader>jb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader>gl", gs.toggle_current_line_blame)
                    map("n", "<leader>jd", gs.diffthis)
                    map("n", "<leader>tD", function()
                        gs.diffthis("~")
                    end)
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })

            vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { silent = true, noremap = true })
        end,
    },
}

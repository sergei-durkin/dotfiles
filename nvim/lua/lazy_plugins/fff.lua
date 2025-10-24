return {
    {
        "dmtrKovalenko/fff.nvim",
        build = function()
            require("fff.download").download_or_build_binary()
        end,
        lazy = false,

        config = function()
            require("fff").setup({
                keymaps = {
                    close = { "<Esc>", "<C-c>" },
                    select = "<CR>",
                    select_split = "<C-s>",
                    select_vsplit = "<C-v>",
                    select_tab = "<C-t>",
                    -- Multiple bindings supported
                    move_up = { "<Up>", "<C-p>" },
                    move_down = { "<Down>", "<C-n>" },
                    preview_scroll_up = "<C-k>",
                    preview_scroll_down = "<C-j>",
                },
            })
        end,
    },
}

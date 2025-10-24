return {
    {
        "rmagatti/goto-preview",
        event = "BufEnter",

        config = function()
            require("goto-preview").setup({
                width = 120,
                height = 15,
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
                default_mappings = true,
                debug = false,
                opacity = nil,
                resizing_mappings = false,
                post_open_hook = nil,
                references = {
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = true,
                preview_window_title = { enable = true, position = "left" },
            })

            -- Keymaps
            vim.keymap.set("n", "gph", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
            vim.keymap.set("n", "gpk", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
            vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
            vim.keymap.set("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>")
            vim.keymap.set("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>")
            vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
        end,
    },
}

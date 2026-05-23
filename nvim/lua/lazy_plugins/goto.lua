return {
    {
        "rmagatti/goto-preview",
        keys = {
            {
                "gph",
                function()
                    require("goto-preview").goto_preview_definition()
                end,
                desc = "Goto preview definition",
            },
            {
                "gpk",
                function()
                    require("goto-preview").goto_preview_type_definition()
                end,
                desc = "Goto preview type definition",
            },
            {
                "gpi",
                function()
                    require("goto-preview").goto_preview_implementation()
                end,
                desc = "Goto preview implementation",
            },
            {
                "gpD",
                function()
                    require("goto-preview").goto_preview_declaration()
                end,
                desc = "Goto preview declaration",
            },
            {
                "gpc",
                function()
                    require("goto-preview").close_all_win()
                end,
                desc = "Close all preview windows",
            },
            {
                "gpr",
                function()
                    require("goto-preview").goto_preview_references()
                end,
                desc = "Goto preview references",
            },
        },

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
                    provider = "default",
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = true,
                preview_window_title = { enable = true, position = "left" },
            })
        end,
    },
}

return {
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewFileHistory",
            "DiffviewFocusFiles",
            "DiffviewToggleFiles",
            "DiffviewRefresh",
        },

        config = function()
            require("diffview").setup()
        end,
    },
}

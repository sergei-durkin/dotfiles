return {
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },

        config = function()
            require("Comment").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            require("todo-comments").setup()
        end,
    },
}

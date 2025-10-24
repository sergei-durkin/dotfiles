return {
    {
        "stevearc/oil.nvim",
        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
        },

        config = function()
            require("oil").setup({
                columns = { "icon" },
            })
        end,
    },
}

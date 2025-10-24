return {
    {
        "okuuva/auto-save.nvim",
        lazy = false,

        config = function()
            require("auto-save").setup()
        end,
    },
}

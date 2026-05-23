return {
    {
        "okuuva/auto-save.nvim",
        event = "InsertEnter",

        config = function()
            require("auto-save").setup()
        end,
    },
}

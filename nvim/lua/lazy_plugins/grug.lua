return {
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        keys = {
            { "⌘R", "<cmd>GrugFar<CR>", desc = "Toggle Grug", silent = true },
        },

        config = function()
            require("grug-far").setup()
        end,
    },
}

return {
    {
        "MagicDuck/grug-far.nvim",

        config = function()
            require("grug-far").setup()

            vim.keymap.set("n", "⌘R", "<cmd>GrugFar<CR>", { noremap = true, silent = true, desc = "Toggle Grug" })
        end,
    },
}

return {
    {
        "vieitesss/miniharp.nvim",

        config = function()
            local miniharp = require("miniharp")

            miniharp.setup()

            vim.keymap.set(
                "n",
                "<leader>m",
                miniharp.toggle_file,
                { noremap = true, desc = "miniharp: toggle file mark" }
            )
            vim.keymap.set("n", "⌃h", miniharp.next, { noremap = true, desc = "miniharp: next file mark" })
            vim.keymap.set("n", "⌃l", miniharp.prev, { noremap = true, desc = "miniharp: prev file mark" })
        end,
    },
}

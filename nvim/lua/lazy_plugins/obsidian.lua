return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "Notes",
                        path = "~/Obsidian",
                    },
                    {
                        name = "Work",
                        path = "~/Documents/Obsidian Vault",
                    },
                },
            })
        end,
    },
}

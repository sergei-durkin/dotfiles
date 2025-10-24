return {
    {
        "nvim-tree/nvim-web-devicons",
        event = "BufRead",

        config = function()
            require("nvim-web-devicons").setup({
                override_by_extension = {
                    ["toml"] = {
                        icon = "",
                        color = "#F288AF",
                        name = "Toml",
                    },
                    ["go"] = {
                        icon = "󰟓",
                        color = "#00ADD8",
                        name = "Go",
                    },
                    ["go.mod"] = {
                        icon = "󰟓 ",
                        color = "#b1e8fa",
                        name = "GoMod",
                    },
                    ["go.sum"] = {
                        icon = "󰟓 ",
                        color = "#b1e8fa",
                        name = "GoSum",
                    },
                    ["brief"] = {
                        icon = "󱓟",
                        color = "#F28131",
                        name = "Brief",
                    },
                    ["proto"] = {
                        icon = "󱓟",
                        color = "#F28131",
                        name = "Proto",
                    },
                },
            })
        end,
    },
}

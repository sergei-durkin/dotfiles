return {
    {
        -- dir = "~/sandbox/gobjdump.nvim",
        "sergei-durkin/gobjdump.nvim",
        cmd = "Gobjdump",

        config = function()
            require("gobjdump").setup({
                build = {
                    args = {
                        "-tags=armtracer",
                        '-gcflags="-N -l"',
                    },
                },
            })
        end,
    },
}

return {
    {
        -- dir = "~/sandbox/gobjdump.nvim",
        "sergei-durkin/gobjdump.nvim",

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

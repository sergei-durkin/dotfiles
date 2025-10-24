return {
    {
        dir = "~/sandbox/gobjdump.nvim",
        url = "sergei-durkin/gobjdump.nvim",
        dev = true,
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

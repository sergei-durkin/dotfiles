return {
    {
        "stevearc/conform.nvim",

        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    systemverilog = { "verible" },
                    verilog = { "verible" },
                },
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 500,
                },
                formatters = {
                    verible = {
                        command = "verible-verilog-format",
                        append_args = { "--column_limit", "100", "--indentation_spaces", "4" },
                    },
                },
            })
        end,
    },
}

return {
    {
        "slugbyte/lackluster.nvim",

        config = function()
            vim.o.termguicolors = true
            -- vim.cmd.colorscheme("catppuccin-macchiato")
            -- vim.cmd.colorscheme("darcula-dark")
            -- vim.cmd.colorscheme("monochrome")
            -- vim.cmd.colorscheme("zenesque")
            -- vim.cmd.colorscheme("default")
            -- vim.cmd.colorscheme("lackluster-dark")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            exclude = {
                filetypes = {
                    "lspinfo",
                    "help",
                    "dashboard",
                },
            },
            scope = {
                enabled = false,
            },
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",

        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "RRethy/vim-illuminate",

        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
            })
        end,
    },
    {
        "wurli/visimatch.nvim",
        opts = {
            hl_group = "IlluminatedWordText",
        },
    },
    -- {
    --     dir = "~/sandbox/darcula-dark.nvim",
    --     url = "sergei-durkin/darcula-dark.nvim",
    --     dev = true,
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --
    --     config = function()
    --         require("darcula").setup({
    --             override = function(_)
    --                 return {
    --                     dark = "#1F2023",
    --                     background = "#2C2D30",
    --                 }
    --             end,
    --             opt = {
    --                 integrations = {
    --                     telescope = false,
    --                     lualine = true,
    --                     lsp_semantics_token = true,
    --                     nvim_cmp = true,
    --                     dap_nvim = true,
    --                 },
    --             },
    --         })
    --
    --         vim.o.termguicolors = true
    --         vim.cmd.colorscheme("darcula-dark")
    --     end,
    -- },
}

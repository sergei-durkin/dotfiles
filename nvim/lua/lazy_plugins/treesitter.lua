return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            max_lines = 2,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = "main",
                init = function()
                    vim.g.no_plugin_maps = true
                end,
            },
        },

        config = function()
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            local ensure_installed = {
                "c",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "lua",
                "typescript",
                "regex",
                "bash",
                "markdown",
                "markdown_inline",
                "sql",
                "html",
                "css",
                "javascript",
                "yaml",
                "json",
                "toml",
                "php",
            }

            require("nvim-treesitter").install(ensure_installed)

            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function()
                    require("nvim-treesitter.parsers").brief = {
                        install_info = {
                            url = "~/sandbox/tree-sitter-brief",
                            files = { "src/parser.c" },
                            branch = "main",
                            generate = true,
                        },
                    }
                end,
            })
            vim.treesitter.language.register("brief", { "brief" })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if ft == "" then
                        return
                    end
                    local lang = vim.treesitter.language.get_lang(ft) or ft
                    local ok, added = pcall(vim.treesitter.language.add, lang)
                    if not ok or not added then
                        return
                    end
                    vim.treesitter.start(args.buf, lang)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldmethod = "expr"
                end,
            })

            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local select_keymaps = {
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ii"] = "@conditional.inner",
                ["ai"] = "@conditional.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["at"] = "@comment.outer",
                ["in"] = "@assignment.lhs",
            }
            for key, capture in pairs(select_keymaps) do
                vim.keymap.set({ "x", "o" }, key, function()
                    select.select_textobject(capture, "textobjects")
                end)
            end

            local move = require("nvim-treesitter-textobjects.move")
            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                move.goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                move.goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                move.goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                move.goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end)

            local swap = require("nvim-treesitter-textobjects.swap")
            vim.keymap.set("n", "<leader>a", function()
                swap.swap_next("@parameter.inner")
            end)
            vim.keymap.set("n", "<leader>A", function()
                swap.swap_previous("@parameter.inner")
            end)

            vim.api.nvim_set_hl(0, "@lsp.type.comment.go", {})
            vim.api.nvim_set_hl(0, "@lsp.type.string.go", {})
        end,
    },
}

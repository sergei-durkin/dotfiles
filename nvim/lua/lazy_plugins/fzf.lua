return {
    {
        "ibhagwan/fzf-lua",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require("fzf-lua").setup({
                fzf_opts = {
                    ["--layout"] = "reverse-list",
                    ["--no-separator"] = "",
                    ["--ansi"] = "",
                    ["--info"] = "inline",
                    ["--prompt"] = "❯",
                },
                files = {
                    prompt = ":",
                },
                live_grep = {
                    prompt = ":",
                },
                grep = {
                    prompt = ":",
                },
                winopts = {
                    height = 0.88,
                    width = 0.88,
                    row = 0.35,
                    col = 0.50,
                    border = "none",
                    backdrop = 60,
                    fullscreen = false,
                    treesitter = {
                        enabled = true,
                    },
                    preview = {
                        border = "none",
                        wrap = false,
                        hidden = false,
                        vertical = "down:45%",
                        horizontal = "right:60%",
                        layout = "horizontal",
                        flip_columns = 100,
                        title = true,
                        title_pos = "center",
                        scrollbar = "float",
                        scrolloff = -1,
                        delay = 20,
                        winopts = {
                            number = true,
                            relativenumber = false,
                            cursorline = true,
                            cursorlineopt = "both",
                            cursorcolumn = false,
                            signcolumn = "no",
                            list = false,
                            foldenable = false,
                            foldmethod = "manual",
                        },
                    },
                },
                previewers = {
                    cat = {
                        cmd = "cat",
                        args = "-n",
                    },
                    bat = {
                        cmd = "bat",
                        args = "--color=always --style=numbers,changes",
                    },
                    head = {
                        cmd = "head",
                        args = nil,
                    },
                    git_diff = {
                        cmd_deleted = "git diff --color HEAD --",
                        cmd_modified = "git diff --color HEAD",
                        cmd_untracked = "git diff --color --no-index /dev/null",
                    },
                    man = {
                        cmd = "man -P cat %s | col -bx",
                    },
                    builtin = {
                        syntax = true,
                        syntax_limit_l = 0,
                        syntax_limit_b = 1024 * 1024,
                        limit_b = 1024 * 1024 * 10,
                        treesitter = {
                            enabled = true,
                        },
                        toggle_behavior = "default",
                        extensions = {
                            ["png"] = { "chafa", "{file}" },
                            ["svg"] = { "chafa", "{file}" },
                            ["jpg"] = { "chafa", "{file}" },
                        },
                        render_markdown = { enabled = true, filetypes = { ["markdown"] = true } },
                    },
                },
            })

            vim.keymap.set("n", "<leader>sf", ":FzfLua files resume=true<CR>", { desc = "[S]earch [F]iles" })
            vim.keymap.set(
                "n",
                "⌘u",
                ":FzfLua grep_curbuf resume=true<CR>",
                { desc = "[/] Fuzzily search in current buffer]" }
            )
            vim.keymap.set("n", "⌘U", ":FzfLua live_grep resume=true<CR>", { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sb", ":FzfLua buffers resume=true<CR>", { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>sS", ":FzfLua git_status resume=true<CR>", { desc = "" })
            vim.keymap.set("i", "<c-f>", "<ESC>:FzfLua complete_path<CR>", { desc = "Complete file path" })
        end,
    },
}

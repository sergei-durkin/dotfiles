return {
    {
        "tpope/vim-obsession",
        cmd = "Obsess",
    },
    {
        "rmagatti/auto-session",
        lazy = false,

        config = function()
            require("auto-session").setup({
                enabled = true,
                auto_save = true,
                auto_restore = true,
                auto_create = true,
                close_filetypes_on_save = { "watch" },
                suppressed_dirs = { "~/", "~/p", "~/Downloads", "/", "~/sandbox", "~/ssh" },
                allowed_dirs = { "~/p/*", "~/sandbox/*", "~/.config", "~/project/*", "~/dotfiles", "~/Obsidian" },
                session_lens = {
                    load_on_setup = true,
                },
            })

            vim.api.nvim_set_keymap("n", "⌘p", ":SessionSearch<CR>", { noremap = true })
        end,
    },
}

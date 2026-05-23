return {
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<CR>", desc = "LazyGit", silent = true },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}

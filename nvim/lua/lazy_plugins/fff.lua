return {
    {
        'dmtrKovalenko/fff.nvim',
        build = function()
            require("fff.download").download_or_build_binary()
        end,

        opts = {
            debug = {
                enabled = false,
                show_scores = true,
            },
            keymaps = {
                preview_scroll_up = '<C-j>',
                preview_scroll_down = '<C-k>',
                cycle_previous_query = '<C-t>',
            },
        },

        lazy = false,
        keys = {
            {
                "ff",
                function() require('fff').find_files() end,
                desc = 'FFFind files',
            },
            {
                "fg",
                function() require('fff').live_grep() end,
                desc = 'LiFFFe grep',
            },
            {
                "fz",
                function()
                    require('fff').live_grep({
                        grep = {
                            modes = { 'fuzzy', 'plain' }
                        }
                    })
                end,
                desc = 'Live fffuzy grep',
            },
            {
                "fc",
                function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
                desc = 'Search current word',
            },
        }
    }
}

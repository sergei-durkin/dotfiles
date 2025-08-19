-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.o.termguicolors = true

require("lazy").setup({
  {
    "nvim-neotest/neotest",
    config = function()
      local neotest_golang_opts = {
        sanitize_output = true,
        testify_enabled = true,
        go_test_args = { "-count=1", "-tags=integration,wireinject" },
        go_list_args = { "-tags=integration,wireinject" },
        dap_go_opts = {
          delve = {
            build_flags = { "-tags=integration,wireinject" },
          },
        },
      }
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(neotest_golang_opts),
        },
      })
    end,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        dependencies = {
          "uga-rosa/utf8.nvim",
        },
      },
    },
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup()
    end
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "echasnovski/mini.ai",
    version = '*',
  },
  {
    "echasnovski/mini.jump2d",
    version = '*',
  },
  {
    "echasnovski/mini.operators",
    version = '*',
  },
  {
    'echasnovski/mini.surround',
    version = '*',
  },
  {
    dir = "~/sandbox/sql-formatter.nvim",
    url = "sergei-durkin/sql-formatter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "wurli/visimatch.nvim",
    opts = {
      hl_group = "IlluminatedWordText",
    }
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    opts = {},
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }
    },
  },
  {
    "rest-nvim/rest.nvim",
  },
  {
    "onsails/lspkind.nvim"
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter"
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "mbbill/undotree",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    dir = "~/sandbox/darcula-dark.nvim",
    url = "sergei-durkin/darcula-dark.nvim",
    dev = true,
    config = function()
      require("darcula").setup({
        override = function(c)
          return {
            dark = "#1F2023",
            background = "#2C2D30"
          }
        end,
        opt = {
          integrations = {
            telescope = false,
            lualine = true,
            lsp_semantics_token = true,
            nvim_cmp = true,
            dap_nvim = true,
          },
        },
      })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
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
      }
    },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex"
        },
      })
    end
  },
  {
    "okuuva/auto-save.nvim",
    lazy = false
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      open_fold_hl_timeout = 400,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
    },
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  {
    "rmagatti/auto-session",
    lazy = false
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "BufRead",
    config = function()
      require("nvim-web-devicons").setup({
        override_by_extension = {
          ["toml"] = {
            icon = "",
            color = "#F288AF",
            name = "Toml",
          },
          ["go"] = {
            icon = "󰟓",
            color = "#00ADD8",
            name = "Go"
          },
          ["go.mod"] = {
            icon = "󰟓 ",
            color = "#b1e8fa",
            name = "GoMod"
          },
          ["go.sum"] = {
            icon = "󰟓 ",
            color = "#b1e8fa",
            name = "GoSum"
          },
          ["brief"] = {
            icon = "󱓟",
            color = "#F28131",
            name = "Brief"
          },
          ["proto"] = {
            icon = "󱓟",
            color = "#F28131",
            name = "Proto"
          },
        }
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
    name = "render-markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  "preservim/vim-pencil",
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  "folke/zen-mode.nvim",
  "tpope/vim-obsession",
  "ThePrimeagen/git-worktree.nvim",
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    config = function()
      require("trouble").setup()
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
                { find = "%d fewer lines" },
                { find = "%d more lines" },
              },
            },
            opts = { skip = true },
          }
        },
        presets = {
          command_palette = true,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "ray-x/go.nvim",
    config = function()
      require('go').setup({
        run_in_floaterm = true,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end
  },
  {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        {
          "mason-org/mason.nvim",
          opts = {}
        },
        "neovim/nvim-lspconfig",
        "j-hui/fidget.nvim",
      },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "nvim-tree/nvim-web-devicons",
    }
  },
  "theHamsta/nvim-dap-virtual-text",
  "leoluz/nvim-dap-go",
  "nvim-lualine/lualine.nvim",
  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    config = true
  },
  "tpope/vim-sleuth",
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable "make" == 1,
  },
  {
    "folke/twilight.nvim",
    ft = "markdown",
  },
})


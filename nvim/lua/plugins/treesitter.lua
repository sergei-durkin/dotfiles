-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'go', 'gomod', 'gosum', 'gotmpl', 'lua', 'typescript', 'regex',
    'bash', 'markdown', 'markdown_inline', 'sql',
    'html', 'css', 'javascript', 'yaml', 'json', 'toml', 'php'
  },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ii'] = '@conditional.inner',
        ['ai'] = '@conditional.outer',
        ['il'] = '@loop.inner',
        ['al'] = '@loop.outer',
        ['at'] = '@comment.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Add treesitter parsers here
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.brief = {
  install_info = {
    url = "~/sandbox/tree-sitter-brief",
    files = {"src/parser.c"},
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = true,
  },
  filetype = "brief",
}

require('treesitter-context').setup({
  enable = true,
  max_lines = 2,
})

-- Enable embedded SQL highlighting
vim.api.nvim_set_hl(0, "@lsp.type.comment.go", {})
vim.api.nvim_set_hl(0, "@lsp.type.string.go", {})

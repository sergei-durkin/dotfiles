return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { {'nvim-tree/nvim-web-devicons'}},
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        header = require('plugins.dashboard.logo')[2],
        shortcut = {
          { desc = '󰊳 Lazy', group = '@property', action = 'Lazy', key = 'l' },
        },
        center = {},
        footer = {},
      }
    })
  end
}

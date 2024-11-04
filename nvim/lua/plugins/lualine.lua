require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 4,
      }
    },
    lualine_b = {
      {
        "harpoon2",
      },
    },
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
    },
  }
}


require('plugins.statuscoolumn.init').setup({
  number = {
    type = "hybrid", -- "hybrid" | "relative" | "normal"
  },
  border = {
    enabled = true,
    text = "│",
  },
  colors = {
    cursorline = {
      bg = "#2C2D30",
    },

    number = {
      normal = "#505258",
      accent = "#9FA0A8",
    },

    diagnostics = {
      error = "#F53855",
      warning = "#D3B988",
      info = "#71CDF4",
      hint = "#CAD0D3",
    },

    git = {
      added = "#A7DB75",
      modified = "#FC9A69",
      removed = "#FF6188",
    },

    git_staged = {
      added = "#5A7C61",
      modified = "#467C7B",
      removed = "#7F605C",
    },
  }
})

vim.o.statuscolumn = "%!v:lua.require('plugins.statuscoolumn.init').render()";

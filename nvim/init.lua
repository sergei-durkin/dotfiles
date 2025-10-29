---@diagnostic disable-next-line: undefined-global
_G.vim = vim

require("options")
require("keymaps")
require("misc")

require("config.lazy")

require("plugins.statuscolumn")
require("plugins.gorun")
require("plugins.rest_private")

require("plugins.tmux-files").setup()

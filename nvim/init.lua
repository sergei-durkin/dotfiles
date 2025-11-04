---@diagnostic disable-next-line: undefined-global
_G.vim = vim

require("options")
require("keymaps")
require("misc")

require("config.lazy")

require("plugins.load")
require("after.load")

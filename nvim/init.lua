require("vim._core.ui2").enable({
    enable = true,
    msg = {
        pager = { height = 0.5 },
        dialog = { height = 0.5 },
        cmd = { height = 0.5 },
        msg = { height = 0.5, timeout = 4500 },
    },
})

---@diagnostic disable-next-line: undefined-global
_G.vim = vim

require("options")
require("keymaps")
require("misc")

require("config.lazy")

require("plugins.load")

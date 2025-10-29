local neotest = require("neotest")

local runCurrentFile = function()
    local command

    if vim.fn.expand("%"):match(".http$") then
        command = "Rest run"
        vim.cmd(command)
        return
    end

    if vim.fn.expand("%"):match("_test.go$") then
        neotest.run.run()
        return
    end

    if vim.fn.expand("%"):match("main.go$") then
        if vim.fn.search("func main") then
            command = string.format("GoRun %s", vim.fn.expand("%"))
            vim.cmd(command)
            return
        end

        print("No main function found")

        return
    end

    if vim.fn.expand("%"):match("main.c$") then
        command = string.format("!gcc %s -o %s && %s", vim.fn.expand("%"), vim.fn.expand("%:r"), vim.fn.expand("%:r"))

        vim.cmd("rightbelow vnew")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { "hello" })
        vim.opt_local.modified = false
        vim.wo.statuscolumn = ""
        vim.wo.number = false
        vim.wo.relativenumber = false

        local lines = vim.split(vim.api.nvim_exec(command, true), "\n", { plain = true })

        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

        vim.cmd(command)

        return
    end

    print("Nothing to run")
end

vim.keymap.set({ "n", "i", "v" }, "<F3>", function()
    runCurrentFile()
end, { silent = true, noremap = true })
vim.keymap.set({ "n", "i", "v" }, "⌘r", function()
    runCurrentFile()
end, { silent = true, noremap = true })

vim.api.nvim_set_keymap("n", "<leader>fs", ":GoFillStruct<CR>", { silent = true, noremap = true })

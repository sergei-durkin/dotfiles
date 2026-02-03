local M = {}

M.bufnrs = {}
M.cur = 1

M.watch = function(e)
    local args = {}
    for arg in string.gmatch(e.args, "%S+") do
        table.insert(args, arg)
    end

    local cmd = args[1]

    if cmd == "new" then
        M.new()
        return
    end

    if cmd == "list" then
        M.list()
        return
    end

    if cmd == "refresh" then
        M.refresh(tonumber(args[2]))
        return
    end

    if cmd == "close" then
        M.close(tonumber(args[2]))
        return
    end
end

M.close = function(bufnr)
    vim.api.nvim_buf_delete(bufnr, { force = true })
    M.bufnrs[bufnr] = nil
end

M.new = function()
    local bufnr = vim.api.nvim_create_buf(true, true)

    local name = string.format("[watch %d]", M.cur)

    M.bufnrs[bufnr] = name
    M.cur = M.cur + 1

    vim.api.nvim_buf_set_name(bufnr, name)
    vim.api.nvim_set_option_value("filetype", "watch", { buf = bufnr })

    local opts = {
        style = "minimal",
        vertical = true,
        split = "right",
    }

    vim.api.nvim_open_win(bufnr, true, opts)

    M.keymap(bufnr)
end

M.keymap = function(bufnr)
    vim.keymap.set("n", "<PageDown>", string.format(":Watch refresh %d<CR>", bufnr), {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = "Refresh current buffer",
    })
    vim.keymap.set({ "i", "v" }, "<PageDown>", string.format("<ESC>:Watch refresh %d<CR>", bufnr), {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = "Refresh current buffer",
    })
end

M.list = function()
    for key, value in pairs(M.bufnrs) do
        print(key, ":", value)
    end
end

M.all = function()
    for key, _ in pairs(M.bufnrs) do
        M.run(key)
    end
end

M.refresh = function(bufnr)
    M.run(bufnr)
end

M.run = function(bufnr)
    local cmd = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { cmd })
    vim.fn.jobstart(cmd, {
        stdout_buffered = false,
        on_stdout = function(_, data)
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end,
        on_exit = function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(win) == bufnr then
                    vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(bufnr), 0 })
                end
            end
        end,
    })
end

M.setup = function()
    vim.api.nvim_create_user_command("Watch", M.watch, { nargs = "?", desc = "watch buf" })

    local awg = vim.api.nvim_create_augroup("AWG", { clear = true })
    vim.api.nvim_create_autocmd("BufDelete", {
        group = awg,
        callback = function(event)
            local ft = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
            if ft == "watch" and M.bufnrs[event.buf] ~= nil then
                M.bufnrs[event.buf] = nil
            end
        end,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = awg,
        callback = M.all,
    })
end

return M

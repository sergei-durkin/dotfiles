local M = {}

local absolute_path_pattern = "^/"
local is_go_file_pattern = "%.go"

M.capture = function()
    local handle = vim.fn.execute("!bash ~/.config/nvim/lua/plugins/capture.sh .go")
    local lines = vim.split(handle, "\n")

    vim.fn.setqflist(vim.tbl_map(function(line)
        if string.match(line, is_go_file_pattern) == nil then
            return nil
        end

        local line_num = string.match(line, ":(%d+)$") or string.match(line, ":(%d+):%d+:?$")
        local col_num = string.match(line, ":%d+:(%d+):?$")
        local file_path = line:match("^(.-):%d+:%d+:?$") or
            line:match("^(.-):%d+:?$") or
            line

        if string.match(line, absolute_path_pattern) then
            file_path = "/" .. file_path
        end

        if not file_path then
            return nil
        end

        return {
            text = line,
            lnum = tonumber(line_num) or 1,
            col = tonumber(col_num) or 1,
            filename = file_path or "",
        }
    end, lines))

    vim.cmd("copen")
end

M.setup = function()
    vim.api.nvim_create_user_command("TmuxCapture", M.capture, {})
end

return M

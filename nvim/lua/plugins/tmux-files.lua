local M = {}

local absolute_path_pattern = "^/"
local file_line_pattern = "^(.-):(%d+)$"
local file_only_pattern = "^(.-)$"
local is_go_file_pattern = "%.go"

M.capture = function()
    local handle = vim.fn.execute("!bash ~/.config/nvim/lua/plugins/capture.sh .go")
    local lines = vim.split(handle, "\n")

    vim.fn.setqflist(vim.tbl_map(function(line)
        if string.match(line, is_go_file_pattern) == nil then
            return nil
        end

        local line_num = string.match(line, ":(%d+)$")
        local file_path = nil

        if line_num then
            file_path = string.match(line, file_line_pattern)
        else
            file_path = string.match(line, file_only_pattern)
        end

        if string.match(line, absolute_path_pattern) then
            file_path = "/" .. file_path
        end

        if not file_path then
            return nil
        end

        return {
            text = line,
            lnum = tonumber(line_num) or 1,
            filename = file_path or "",
        }
    end, lines))

    vim.cmd("copen")
end

M.setup = function()
    vim.api.nvim_create_user_command("TmuxCapture", M.capture, {})
end

return M

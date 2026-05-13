local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
local autocmd = vim.api.nvim_create_autocmd
local _, MiniFiles = pcall(require, "mini.files")

local gitStatusCache = {}
local currentGitRoot = nil
local cacheTimeout = 2000
local uv = vim.uv or vim.loop

local function isSymlink(path)
    local stat = uv.fs_lstat(path)
    return stat and stat.type == "link"
end

local function mapSymbols(status, is_symlink)
    local statusMap = {
        [" M"] = { symbol = "•", hlGroup = "GitSignsChange" },
        ["M "] = { symbol = "✹", hlGroup = "GitSignsChange" },
        ["MM"] = { symbol = "≠", hlGroup = "GitSignsChange" },
        ["A "] = { symbol = "+", hlGroup = "GitSignsAdd" },
        ["AA"] = { symbol = "≈", hlGroup = "GitSignsAdd" },
        ["D "] = { symbol = "-", hlGroup = "GitSignsDelete" },
        ["AM"] = { symbol = "⊕", hlGroup = "GitSignsChange" },
        ["AD"] = { symbol = "-•", hlGroup = "GitSignsChange" },
        ["R "] = { symbol = "→", hlGroup = "GitSignsChange" },
        ["U "] = { symbol = "‖", hlGroup = "GitSignsChange" },
        ["UU"] = { symbol = "⇄", hlGroup = "GitSignsAdd" },
        ["UA"] = { symbol = "⊕", hlGroup = "GitSignsAdd" },
        ["??"] = { symbol = "?", hlGroup = "GitSignsDelete" },
        ["!!"] = { symbol = "!", hlGroup = "GitSignsChange" },
    }

    local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
    local symlinkSymbol = is_symlink and "↩" or ""
    local combinedSymbol = (symlinkSymbol .. result.symbol):gsub("^%s+", ""):gsub("%s+$", "")
    local combinedHlGroup = is_symlink and "GitSignsDelete" or result.hlGroup
    return combinedSymbol, combinedHlGroup
end

local function fetchGitStatus(cwd, callback)
    local clean_cwd = cwd:gsub("^minifiles://%d+/", "")
    vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = clean_cwd }, function(content)
        if content.code == 0 then
            callback(content.stdout)
        end
    end)
end

local function updateMiniWithGit(buf_id, gitStatusMap)
    vim.schedule(function()
        if not currentGitRoot then
            return
        end
        local nlines = vim.api.nvim_buf_line_count(buf_id)
        local escapedcwd = vim.fs.normalize(vim.pesc(currentGitRoot))
        local matched = 0

        for i = 1, nlines do
            local entry = MiniFiles.get_fs_entry(buf_id, i)
            if not entry then
                break
            end
            local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
            local status = gitStatusMap[relativePath]
            if status then
                matched = matched + 1
                local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
                vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
                    sign_text = symbol,
                    sign_hl_group = hlGroup,
                    priority = 2,
                })
                local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
                local nameStartCol = line:find(vim.pesc(entry.name)) or 0
                if nameStartCol > 0 then
                    vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
                        end_col = nameStartCol + #entry.name - 1,
                        hl_group = hlGroup,
                    })
                end
            end
        end
    end)
end

local function parseGitStatus(content)
    local gitStatusMap = {}
    for line in content:gmatch("[^\r\n]+") do
        local status, filePath = string.match(line, "^(..)%s+(.*)")
        local parts = {}
        for part in filePath:gmatch("[^/]+") do
            table.insert(parts, part)
        end
        local currentKey = ""
        for i, part in ipairs(parts) do
            currentKey = i > 1 and (currentKey .. "/" .. part) or part
            if i == #parts then
                gitStatusMap[currentKey] = status
            elseif not gitStatusMap[currentKey] then
                gitStatusMap[currentKey] = status
            end
        end
    end
    return gitStatusMap
end

local function updateAllMiniFilesBuffers(gitStatusMap)
    local count = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("^minifiles://") then
            count = count + 1
            updateMiniWithGit(buf, gitStatusMap)
        end
    end
end

local function updateGitStatus(buf_id)
    local root = vim.fs.root(vim.uv.cwd(), ".git")
    if not root then
        return
    end
    currentGitRoot = root
    local currentTime = os.time()
    if gitStatusCache[root] and currentTime - gitStatusCache[root].time < cacheTimeout then
        updateAllMiniFilesBuffers(gitStatusCache[root].statusMap)
    else
        fetchGitStatus(root, function(content)
            vim.schedule(function()
                local gitStatusMap = parseGitStatus(content)
                gitStatusCache[root] = { time = currentTime, statusMap = gitStatusMap }
                updateAllMiniFilesBuffers(gitStatusMap)
            end)
        end)
    end
end

local function augroup(name)
    return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
end

autocmd("User", {
    group = augroup("start"),
    pattern = "MiniFilesExplorerOpen",
    callback = function()
        updateGitStatus(vim.api.nvim_get_current_buf())
    end,
})

autocmd("User", {
    group = augroup("close"),
    pattern = "MiniFilesExplorerClose",
    callback = function()
        gitStatusCache = {}
        currentGitRoot = nil
    end,
})

autocmd("User", {
    group = augroup("update"),
    pattern = "MiniFilesBufferUpdate",
    callback = function(args)
        if currentGitRoot and gitStatusCache[currentGitRoot] then
            updateMiniWithGit(args.data.buf_id, gitStatusCache[currentGitRoot].statusMap)
        end
    end,
})

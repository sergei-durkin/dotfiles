local utils = {}

local function get_hl(sign_name)
  if sign_name:match("Error") then
    return "LspDiagnosticsSignError"
  elseif sign_name:match("Warn") then
    return "LspDiagnosticsSignWarning"
  elseif sign_name:match("Info") then
    return "LspDiagnosticsSignInformation"
  elseif sign_name:match("Hint") then
    return "LspDiagnosticsSignHint"
  elseif sign_name:match("WARN") then
    return "LspDiagnosticsSignWarning"
  elseif sign_name:match("TODO") then
    return "LspDiagnosticsSignHint"
  elseif sign_name:match("NOTE") then
    return "LspDiagnosticsSignInformation"
  elseif sign_name:match("Git") then
    return sign_name
  end
  return "LspDiagnosticsSignError"
end

utils.get_signs = function(buf, lnum)
  local signs = {}
  local placed_signs = vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs
  for _, sign in ipairs(placed_signs) do
    local defined_sign = vim.fn.sign_getdefined(sign.name)[1]
    if defined_sign then
      local ret = {
        name = defined_sign.name,
        text = defined_sign.text,
        texthl = defined_sign.texthl,
        priority = sign.priority,
      }
      table.insert(signs, ret)
    end
  end

  local extmarks = vim.api.nvim_buf_get_extmarks(
    buf,
    -1,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true, type = "sign" }
  )

  for _, extmark in pairs(extmarks) do
    signs[#signs + 1] = {
      name = extmark[4].sign_hl_group or "",
      text = extmark[4].sign_text,
      texthl = extmark[4].sign_hl_group,
      priority = extmark[4].priority,
    }
  end

  table.sort(signs, function(a, b)
    return (a.priority or 0) < (b.priority or 0)
  end)

  return signs
end

utils.icon = function(sign)
  if not sign then
    return "%#StatusColumnNumbers# "
  end

  local text = vim.fn.strcharpart(sign.text or "", 0, 1)
  if sign.texthl then
    sign.texthl = get_hl(sign.name)
    if vim.v.lnum == vim.fn.line(".") then
      return string.format("%%#StatusColumnNumbers#%%#%s#%%X%s%%*", sign.texthl, text)
    end

    return string.format("%%#%s#%s%%*", sign.texthl, text)
  end

  return text
end

return utils

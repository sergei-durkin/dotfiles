local statuscolumn = {
  bg = "#373438",
  colors = {
    number = "#505258",
    number_current = "#9FA0A8",

    diagnostics = {
      error = "#FF6188",
      warning = "#FFCA80",
      info = "#A9DC76",
      hint = "#76E3EA",
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
};

local function get_hl(sign_name)
  if sign_name:match("Error") then
    return "LspDiagnosticsSignError"
  elseif sign_name:match("Warn") then
    return "LspDiagnosticsSignWarning"
  elseif sign_name:match("Info") then
    return "LspDiagnosticsSignInformation"
  elseif sign_name:match("Hint") then
    return "LspDiagnosticsSignHint"
  elseif sign_name:match("TODO") then
    return "LspDiagnosticsSignHint"
  elseif sign_name:match("NOTE") then
    return "LspDiagnosticsSignHint"
  elseif sign_name:match("GitSignsAdd") then
    return "GitSignsAdd"
  elseif sign_name:match("GitSignsChange") then
    return "GitSignsChange"
  elseif sign_name:match("GitSignsDelete") then
    return "GitSignsDelete"
  elseif sign_name:match("GitSignsStaged") then
    return sign_name
  end
  return "LspDiagnosticsSignError"
end

local function get_signs(buf, lnum)
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

local function icon(sign)
  if not sign then
    return "%#StatusColumnNumbers# "
  end
  local text = vim.fn.strcharpart(sign.text or "", 0, 1)
  if sign.texthl then
    sign.texthl = get_hl(sign.name)
    if vim.v.lnum == vim.fn.line(".") then
      return string.format("%%#StatusColumnNumbers#%%#%s#%%X%s%%*", sign.texthl, text)
    else
      return string.format("%%#%s#%s%%*", sign.texthl, text)
    end
  else
    return text
  end
end

statuscolumn.setHl = function ()
  local _bg
  if vim.v.relnum == 0 then
    _bg = statuscolumn.bg;
  end

  vim.api.nvim_set_hl(0, "StatusColumnNumbers", {
    fg = statuscolumn.colors.number,
    bg = _bg,
  });
  
  vim.api.nvim_set_hl(0, "StatusColumnNumbersAccent", {
    fg = statuscolumn.colors.number_current,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", {
    fg = statuscolumn.colors.diagnostics.error,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", {
    fg = statuscolumn.colors.diagnostics.warning,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", {
    fg = statuscolumn.colors.diagnostics.info,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", {
    fg = statuscolumn.colors.diagnostics.hint,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsAdd", {
    fg = statuscolumn.colors.git.added,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsChange", {
    fg = statuscolumn.colors.git.modified,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsDelete", {
    fg = statuscolumn.colors.git.removed,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedAdd", {
    fg = statuscolumn.colors.git_staged.added,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedChange", {
    fg = statuscolumn.colors.git_staged.modified,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedDelete", {
    fg = statuscolumn.colors.git_staged.removed,
    bg = _bg,
  });
end

statuscolumn.fold = function (cfg)
  local _output = "";

  local foldlvl_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and (vim.v.lnum - 1) or 1);
  local foldlvl_current = vim.fn.foldlevel(vim.v.lnum);
  local foldlvl_after = vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1) or vim.fn.line("$"));

  local foldclosed = vim.fn.foldclosed(vim.v.lnum);

  if type(cfg.hl.default) == "string" then
    _output = "%#" .. cfg.hl.default .. "#";
  end

  if foldlvl_current == 0 then
    _output = type(cfg.space) == "string" and _output .. cfg.space or _output .. " ";

    return _output;
  end

  if foldclosed ~= -1 and foldclosed == vim.v.lnum then
    _output = type(cfg.hl.closed) == "string" and _output .. "%#" .. cfg.hl.closed .. "#" or _output;
    _output = type(cfg.text.closed) == "string" and _output .. cfg.text.closed or _output .. "-";

    return _output;
  end

  if foldlvl_current > foldlvl_before then
    _output = type(cfg.hl.opened) == "string" and _output .. "%#" .. cfg.hl.opened .. "#" or _output;
    _output = type(cfg.text.opened) == "string" and _output .. cfg.text.opened or _output .. "+";

    return _output;
  end

  _output = type(cfg.hl.scope) == "string" and _output .. "%#" .. cfg.hl.scope .. "#" or _output;
  _output = type(cfg.text.scope) == "string" and _output .. cfg.text.scope or _output .. " ";

  return _output;
end

statuscolumn.number = function (cfg)
  local _output, _color = "", "";
    local pref = ""
    if cfg.icon and cfg.icon.text then
      _icon = icon(cfg.icon)
      _output = "%=" .. _icon
      return _output
  end

  if cfg.mode == "normal" then
    _output = vim.v.lnum;
  end

  if cfg.mode == "relative" then
    _output = vim.v.relnum;
  end

  if cfg.mode == "hybrid" then
    _output = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum;
  end

  _color = type(cfg.hl) == "string" and "%#" .. cfg.hl .. "#" or "";
  if cfg.current_line_hl and vim.v.lnum == vim.fn.line(".") then
    _color = "%#" .. cfg.current_line_hl .. "#";
  end

  return _color ~= "" and _color .. "%=%{" .. _output .. "}" or "%=%{ " .. _output .. "}";
end

statuscolumn.gap = function (cfg)
  local _output = "";

  if type(cfg.hl) == "string" then
    _output = "%#" .. cfg.hl .. "#"
  end

  _output = _output .. cfg.text;

  return _output;
end

statuscolumn.border = function (cfg)
  local _output = "";

  if cfg.hl == nil then
    return cfg.text;
  end

  return _output;
end

statuscolumn.setup = function ()
  local text = ""

  local bufnr = vim.api.nvim_get_current_buf()
  local signs = get_signs(bufnr, vim.v.lnum)
  local git_sign, number_icon

  for _, s in ipairs(signs) do
    if s.name and s.name:find("GitSign") then
      git_sign = s
    else
      number_icon = s
    end
  end

  statuscolumn.setHl();

  return table.concat({
    icon(git_sign) or " ",
    statuscolumn.gap({
      hl = "StatusColumnNumbersAccent",
      text = " ",
    }),
    statuscolumn.number({
      hl = "StatusColumnNumbers",
      current_line_hl = "StatusColumnNumbersAccent",
      mode = "hybrid",
      right_align = true,
      icon = number_icon,
    }),
    statuscolumn.gap({
      hl = "StatusColumnNumbers",
      text = " ",
    }),
    statuscolumn.fold({
      hl = {
        default = "StatusColumnNumbers",
        opened = "StatusColumnNumbers",
        closed = "StatusColumnNumbers",
        scope = "StatusColumnNumbers",
      },
      text = {
        opened = "",
        closed = "", -- ›
        scope = " ",
      },
    }),
    statuscolumn.gap({
      hl = "StatusColumnNumbers",
      text = " ",
    }),
    statuscolumn.border({
      text = "│",
    }),
  })
end

return statuscolumn;

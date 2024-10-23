-- Maybe this should be a plugin, but I'm not sure yet.
-- I'm still learning how to write plugins in lua.
-- I'm not sure if this is the best way to do it.
local utils = require("plugins.statuscoolumn.utils")

local statuscolumn = {};

local catppuccino_macchiato = {
  cursorline = {
    bg = "#383838",
  },
  number = {
    normal = "#606684",
    accent = "#B9C4F8",
  },

  diagnostics = {
    error = "#FF6188",
    warning = "#FFCA80",
    info = "#A9DC76",
    hint = "#76E3EA",
  },

  git = {
    added = "#A6DA95",
    modified = "#EED4A0",
    removed = "#ED8796",
  },

  git_staged = {
    added = "#5A7C61",
    modified = "#467C7B",
    removed = "#7F605C",
  },
}

statuscolumn.config = {
  number = {
    type = "hybrid",
  },

  border = {
    enabled = true,
    text = "│",
  },

  fold = {
    enabled = true,
    text = {
      opened = "",
      closed = "",
      scope = " ",
    }
  },

  colors = catppuccino_macchiato;
}

statuscolumn.setHl = function ()
  local _bg
  if vim.v.lnum == vim.fn.line(".") then
    _bg = statuscolumn.config.colors.cursorline.bg;
  end

  vim.api.nvim_set_hl(0, "StatusColumnNumbers", {
    fg = statuscolumn.config.colors.number.normal,
    bg = _bg,
  });
  
  vim.api.nvim_set_hl(0, "StatusColumnNumbersAccent", {
    fg = statuscolumn.config.colors.number.accent,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", {
    fg = statuscolumn.config.colors.diagnostics.error,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", {
    fg = statuscolumn.config.colors.diagnostics.warning,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", {
    fg = statuscolumn.config.colors.diagnostics.info,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", {
    fg = statuscolumn.config.colors.diagnostics.hint,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsAdd", {
    fg = statuscolumn.config.colors.git.added,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsChange", {
    fg = statuscolumn.config.colors.git.modified,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsDelete", {
    fg = statuscolumn.config.colors.git.removed,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedAdd", {
    fg = statuscolumn.config.colors.git_staged.added,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedChange", {
    fg = statuscolumn.config.colors.git_staged.modified,
    bg = _bg,
  });

  vim.api.nvim_set_hl(0, "GitSignsStagedDelete", {
    fg = statuscolumn.config.colors.git_staged.removed,
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
  local _output, _color = "", ""

  if cfg.icon and cfg.icon.text then
      _icon = utils.icon(cfg.icon)
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

statuscolumn.render = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local signs = utils.get_signs(bufnr, vim.v.lnum)
  local git_sign, number_icon

  for _, s in ipairs(signs) do
    if s.name and s.name:find("Git") then
      git_sign = utils.icon(s)
    else
      number_icon = s
    end
  end

  statuscolumn.setHl();

  return table.concat({
    -- render gitsigns
    git_sign or " ",

    statuscolumn.gap({
      hl = "StatusColumnNumbers",
      text = " ",
    }),

    -- render number
    statuscolumn.number({
      hl = "StatusColumnNumbers",
      current_line_hl = "StatusColumnNumbersAccent",
      mode = statuscolumn.config.number.type,
      right_align = true,
      icon = number_icon,
    }),

    statuscolumn.gap({
      hl = "StatusColumnNumbers",
      text = " ",
    }),
    
    -- render fold
    statuscolumn.config.fold.enabled and statuscolumn.fold({
      hl = {
        default = "StatusColumnNumbers",
        opened = "StatusColumnNumbers",
        closed = "StatusColumnNumbers",
        scope = "StatusColumnNumbers",
      },
      text = statuscolumn.config.fold.text,
    }) or "",

    statuscolumn.gap({
      hl = "StatusColumnNumbers",
      text = " ",
    }),

    -- render border
    statuscolumn.config.border.enabled and statuscolumn.border({
      text = statuscolumn.config.border.text,
    }) or "",
  })
end

statuscolumn.setup = function (cfg)
  if not cfg then
    return
  end

  statuscolumn.config = vim.tbl_deep_extend("force", statuscolumn.config, cfg)
end

return statuscolumn;

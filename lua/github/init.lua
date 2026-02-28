-- GitHub colorscheme for Neovim
-- Based on the OpenCode github theme

local M = {}

M.name = "github"

-- Apply a table of highlight groups
local function apply_highlights(groups)
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

-- Load and apply the colorscheme
function M.load()
  -- Reset everything
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Set colorscheme properties
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = M.name

  -- Load palette
  local palette = require("github.palette")

  -- Load and apply all highlight groups
  local groups = {
    require("github.groups.editor"),
    require("github.groups.syntax"),
    require("github.groups.treesitter"),
    require("github.groups.lsp"),
    require("github.groups.plugins"),
  }

  for _, group_module in ipairs(groups) do
    apply_highlights(group_module.get(palette))
  end

  -- Set terminal colors
  M.set_terminal_colors(palette)
end

-- Set terminal colors for :terminal
function M.set_terminal_colors(p)
  -- Black
  vim.g.terminal_color_0 = p.dark500
  vim.g.terminal_color_8 = p.dark300

  -- Red
  vim.g.terminal_color_1 = p.error
  vim.g.terminal_color_9 = p.error_light

  -- Green
  vim.g.terminal_color_2 = p.success
  vim.g.terminal_color_10 = p.success_light

  -- Yellow
  vim.g.terminal_color_3 = p.warning
  vim.g.terminal_color_11 = p.warning_light

  -- Blue
  vim.g.terminal_color_4 = p.info
  vim.g.terminal_color_12 = p.info_light

  -- Magenta
  vim.g.terminal_color_5 = p.syntax.func
  vim.g.terminal_color_13 = p.syntax.keyword

  -- Cyan
  vim.g.terminal_color_6 = p.hint
  vim.g.terminal_color_14 = p.hint

  -- White
  vim.g.terminal_color_7 = p.fg_muted
  vim.g.terminal_color_15 = p.fg
end

-- Get the lualine theme
function M.lualine()
  return require("github.lualine").get()
end

-- Setup function (optional, for future configuration options)
function M.setup(opts)
  opts = opts or {}
  M.load()
end

return M

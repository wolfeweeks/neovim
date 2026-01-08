-- Boost colorscheme for Neovim
-- A dark theme with gold accents based on OpenCode p3-boost

local M = {}

M.name = "boost"

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
  local palette = require("boost.palette")

  -- Load and apply all highlight groups
  local groups = {
    require("boost.groups.editor"),
    require("boost.groups.syntax"),
    require("boost.groups.treesitter"),
    require("boost.groups.lsp"),
    require("boost.groups.plugins"),
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
  vim.g.terminal_color_3 = p.gold600
  vim.g.terminal_color_11 = p.gold400

  -- Blue
  vim.g.terminal_color_4 = p.info
  vim.g.terminal_color_12 = p.info_light

  -- Magenta
  vim.g.terminal_color_5 = "#9c27b0"
  vim.g.terminal_color_13 = "#ba68c8"

  -- Cyan
  vim.g.terminal_color_6 = "#00838f"
  vim.g.terminal_color_14 = "#00bcd4"

  -- White
  vim.g.terminal_color_7 = p.fg_muted
  vim.g.terminal_color_15 = p.fg
end

-- Get the lualine theme
function M.lualine()
  return require("boost.lualine").get()
end

-- Setup function (optional, for future configuration options)
function M.setup(opts)
  opts = opts or {}
  M.load()
end

return M

-- GitHub colorscheme - Lualine theme
-- Custom statusline theme with blue accents

local M = {}

function M.get()
  local p = require("github.palette")

  return {
    normal = {
      a = { fg = p.fg_dark, bg = p.gold400, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    insert = {
      a = { fg = p.fg_dark, bg = p.info_light, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    visual = {
      a = { fg = p.fg_dark, bg = p.gold300, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    replace = {
      a = { fg = p.fg, bg = p.error, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    command = {
      a = { fg = p.fg_dark, bg = p.gold500, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    terminal = {
      a = { fg = p.fg_dark, bg = p.success_light, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_element },
      c = { fg = p.fg_muted, bg = p.bg_elevated },
    },
    inactive = {
      a = { fg = p.fg_muted, bg = p.bg_element },
      b = { fg = p.fg_muted, bg = p.bg_elevated },
      c = { fg = p.dark200, bg = p.bg },
    },
  }
end

return M

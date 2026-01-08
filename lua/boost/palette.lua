-- Boost colorscheme palette
-- Based on OpenCode p3-boost theme

local M = {}

-- Gold accent scale
M.gold50 = "#ffe765"
M.gold100 = "#ffe558"
M.gold200 = "#ffe13f"
M.gold300 = "#ffde25"
M.gold400 = "#ffda0b"
M.gold500 = "#f1cc00"
M.gold600 = "#d7b600"
M.gold700 = "#bea100"
M.gold800 = "#a48b00"
M.gold900 = "#8b7600"

-- Dark scale
M.dark50 = "#82777a"
M.dark100 = "#776d70"
M.dark200 = "#62595c"
M.dark300 = "#4d4648"
M.dark400 = "#373234"
M.dark500 = "#221f20"
M.dark600 = "#050404"

-- Base colors
M.bg = M.dark500
M.bg_elevated = "#2C2A2B"
M.bg_element = M.dark400
M.bg_visual = "#3a3428" -- subtle gold tint for selection
M.bg_search = M.gold600
M.bg_cursor_line = "#2a2627"

M.fg = "#EEEEEE"
M.fg_muted = M.dark50
M.fg_dark = M.dark500

-- Borders
M.border = M.dark300
M.border_active = M.gold500
M.border_subtle = M.dark400

-- Semantic colors
M.error = "#d32f2f"
M.error_light = "#ef5350"
M.error_bg = "#3d1b1b"

M.warning = "#ed6c02"
M.warning_light = "#ff9800"
M.warning_bg = "#3d2e1b"

M.success = "#2e7d32"
M.success_light = "#4caf50"
M.success_bg = "#1b3d1b"

M.info = "#0288d1"
M.info_light = "#03a9f4"
M.info_bg = "#1b2d3d"

M.hint = M.gold600
M.hint_bg = "#2d2a1b"

-- Diff colors
M.diff_add = M.success
M.diff_add_bg = M.success_bg
M.diff_delete = M.error
M.diff_delete_bg = M.error_bg
M.diff_change = M.info
M.diff_change_bg = M.info_bg
M.diff_text = M.info_light

-- Syntax colors (mapped from theme)
M.syntax = {
  comment = M.dark50,
  keyword = M.gold500,
  func = M.info_light,
  variable = M.gold300,
  string = M.success_light,
  number = M.warning_light,
  type = M.gold400,
  operator = M.gold500,
  punctuation = M.fg,
  constant = M.warning_light,
  parameter = M.gold200,
  property = M.gold300,
  field = M.gold300,
  namespace = M.gold600,
  tag = M.gold500,
  attribute = M.gold400,
  constructor = M.gold400,
  special = M.warning_light,
  regex = M.warning,
  escape = M.warning,
}

-- Git colors
M.git = {
  add = M.success_light,
  change = M.info_light,
  delete = M.error_light,
  ignore = M.dark200,
  rename = M.info_light,
  conflict = M.warning_light,
}

-- None value for transparent
M.none = "NONE"

return M

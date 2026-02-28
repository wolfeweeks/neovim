-- GitHub colorscheme palette
-- Based on the OpenCode github theme

local M = {}

-- Blue accent scale
M.gold50 = "#e8f2ff"
M.gold100 = "#c9e2ff"
M.gold200 = "#9ecbff"
M.gold300 = "#79c0ff"
M.gold400 = "#58a6ff"
M.gold500 = "#388bfd"
M.gold600 = "#1f6feb"
M.gold700 = "#1158c7"
M.gold800 = "#0d419d"
M.gold900 = "#0c2d6b"

-- Dark scale
M.dark50 = "#8b949e"
M.dark100 = "#6e7681"
M.dark200 = "#484f58"
M.dark300 = "#30363d"
M.dark400 = "#21262d"
M.dark500 = "#0d1117"
M.dark600 = "#010409"

-- Base colors
M.bg = M.dark500
M.bg_elevated = "#161b22"
M.bg_element = "#21262d"
M.bg_visual = "#1f2937"
M.bg_search = "#e3b341"
M.bg_cursor_line = "#161b22"

M.fg = "#c9d1d9"
M.fg_muted = M.dark50
M.fg_dark = M.dark500

-- Borders
M.border = "#30363d"
M.border_active = M.gold400
M.border_subtle = "#21262d"

-- Semantic colors
M.error = "#f85149"
M.error_light = "#ff7b72"
M.error_bg = "#67060c"

M.warning = "#d29922"
M.warning_light = "#e3b341"
M.warning_bg = "#3d2a0f"

M.success = "#3fb950"
M.success_light = "#56d364"
M.success_bg = "#033a16"

M.info = "#58a6ff"
M.info_light = "#79c0ff"
M.info_bg = "#0b223a"

M.hint = "#39c5cf"
M.hint_bg = "#0b2f33"

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
  comment = "#8b949e",
  keyword = "#ff7b72",
  func = "#bc8cff",
  variable = "#d29922",
  string = "#39c5cf",
  number = "#58a6ff",
  type = "#d29922",
  operator = "#ff7b72",
  punctuation = "#c9d1d9",
  constant = "#e3b341",
  parameter = "#d29922",
  property = "#58a6ff",
  field = "#58a6ff",
  namespace = "#bc8cff",
  tag = "#58a6ff",
  attribute = "#e3b341",
  constructor = "#bc8cff",
  special = "#e3b341",
  regex = "#ff7b72",
  escape = "#ff7b72",
}

-- Git colors
M.git = {
  add = "#3fb950",
  change = "#58a6ff",
  delete = "#f85149",
  ignore = "#484f58",
  rename = "#bc8cff",
  conflict = "#d29922",
}

-- None value for transparent
M.none = "NONE"

return M

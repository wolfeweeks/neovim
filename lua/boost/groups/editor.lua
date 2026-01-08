-- Boost colorscheme - Editor highlight groups
-- Core Neovim UI elements

local M = {}

function M.get(p)
  return {
    -- Base UI
    Normal = { fg = p.fg, bg = p.bg },
    NormalNC = { fg = p.fg, bg = p.bg },
    NormalFloat = { fg = p.fg, bg = p.bg_elevated },
    FloatBorder = { fg = p.border, bg = p.bg_elevated },
    FloatTitle = { fg = p.gold500, bg = p.bg_elevated, bold = true },
    WinSeparator = { fg = p.border },
    VertSplit = { fg = p.border },

    -- Cursor
    Cursor = { fg = p.bg, bg = p.gold500 },
    lCursor = { fg = p.bg, bg = p.gold500 },
    CursorIM = { fg = p.bg, bg = p.gold500 },
    CursorLine = { bg = p.bg_cursor_line },
    CursorColumn = { bg = p.bg_cursor_line },
    TermCursor = { fg = p.bg, bg = p.gold500 },
    TermCursorNC = { fg = p.bg, bg = p.fg_muted },

    -- Line numbers
    LineNr = { fg = p.dark200 },
    LineNrAbove = { fg = p.dark200 },
    LineNrBelow = { fg = p.dark200 },
    CursorLineNr = { fg = p.gold500, bold = true },
    CursorLineFold = { fg = p.gold500 },
    CursorLineSign = { bg = p.bg_cursor_line },

    -- Sign column
    SignColumn = { fg = p.fg_muted, bg = p.bg },
    FoldColumn = { fg = p.dark200, bg = p.bg },

    -- Search & selection
    Search = { fg = p.fg_dark, bg = p.bg_search },
    IncSearch = { fg = p.fg_dark, bg = p.gold400, bold = true },
    CurSearch = { fg = p.fg_dark, bg = p.gold300, bold = true },
    Substitute = { fg = p.fg_dark, bg = p.warning },
    Visual = { bg = p.bg_visual },
    VisualNOS = { bg = p.bg_visual },

    -- Popup menu (completion)
    Pmenu = { fg = p.fg, bg = p.bg_elevated },
    PmenuSel = { fg = p.fg, bg = p.bg_element, bold = true },
    PmenuSbar = { bg = p.bg_element },
    PmenuThumb = { bg = p.dark200 },
    PmenuKind = { fg = p.gold500, bg = p.bg_elevated },
    PmenuKindSel = { fg = p.gold400, bg = p.bg_element, bold = true },
    PmenuExtra = { fg = p.fg_muted, bg = p.bg_elevated },
    PmenuExtraSel = { fg = p.fg_muted, bg = p.bg_element },

    -- Statusline
    StatusLine = { fg = p.fg, bg = p.bg_elevated },
    StatusLineNC = { fg = p.fg_muted, bg = p.bg_element },
    WinBar = { fg = p.fg, bg = p.bg, bold = true },
    WinBarNC = { fg = p.fg_muted, bg = p.bg },

    -- Tabline
    TabLine = { fg = p.fg_muted, bg = p.bg_element },
    TabLineFill = { bg = p.bg },
    TabLineSel = { fg = p.fg, bg = p.bg_elevated, bold = true },

    -- Messages
    ModeMsg = { fg = p.gold500, bold = true },
    MsgArea = { fg = p.fg },
    MsgSeparator = { fg = p.border },
    MoreMsg = { fg = p.gold500, bold = true },
    Question = { fg = p.gold500 },
    ErrorMsg = { fg = p.error_light, bold = true },
    WarningMsg = { fg = p.warning_light, bold = true },

    -- Diff
    DiffAdd = { bg = p.diff_add_bg },
    DiffChange = { bg = p.diff_change_bg },
    DiffDelete = { fg = p.diff_delete, bg = p.diff_delete_bg },
    DiffText = { bg = p.info_bg, bold = true },
    diffAdded = { fg = p.diff_add },
    diffRemoved = { fg = p.diff_delete },
    diffChanged = { fg = p.diff_change },
    diffOldFile = { fg = p.warning },
    diffNewFile = { fg = p.success_light },
    diffFile = { fg = p.info_light },
    diffLine = { fg = p.fg_muted },
    diffIndexLine = { fg = p.gold600 },

    -- Folds
    Folded = { fg = p.fg_muted, bg = p.bg_element },
    FoldColumn = { fg = p.dark200 },

    -- Spelling
    SpellBad = { sp = p.error_light, undercurl = true },
    SpellCap = { sp = p.warning_light, undercurl = true },
    SpellLocal = { sp = p.info_light, undercurl = true },
    SpellRare = { sp = p.gold400, undercurl = true },

    -- Misc UI
    ColorColumn = { bg = p.bg_element },
    Conceal = { fg = p.dark200 },
    Directory = { fg = p.gold500 },
    EndOfBuffer = { fg = p.bg },
    MatchParen = { fg = p.gold300, bg = p.dark300, bold = true },
    NonText = { fg = p.dark300 },
    SpecialKey = { fg = p.dark300 },
    Title = { fg = p.gold500, bold = true },
    Whitespace = { fg = p.dark300 },
    WildMenu = { fg = p.fg_dark, bg = p.gold500 },
    Winseparator = { fg = p.border },

    -- Quickfix
    QuickFixLine = { bg = p.bg_visual, bold = true },
    qfFileName = { fg = p.gold500 },
    qfLineNr = { fg = p.fg_muted },

    -- Health check
    healthError = { fg = p.error_light },
    healthSuccess = { fg = p.success_light },
    healthWarning = { fg = p.warning_light },

    -- Neovim specific
    NvimInternalError = { fg = p.error_light, bg = p.error_bg },
    RedrawDebugNormal = { reverse = true },
    RedrawDebugClear = { bg = p.warning_bg },
    RedrawDebugComposed = { bg = p.success_bg },
    RedrawDebugRecompose = { bg = p.error_bg },
  }
end

return M

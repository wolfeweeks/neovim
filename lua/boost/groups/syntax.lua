-- Boost colorscheme - Syntax highlight groups
-- Base Vim syntax groups (used as fallback when Treesitter not available)

local M = {}

function M.get(p)
  local s = p.syntax

  return {
    -- Comments
    Comment = { fg = s.comment, italic = true },

    -- Constants
    Constant = { fg = s.constant },
    String = { fg = s.string },
    Character = { fg = s.string },
    Number = { fg = s.number },
    Boolean = { fg = s.constant, bold = true },
    Float = { fg = s.number },

    -- Identifiers
    Identifier = { fg = s.variable },
    Function = { fg = s.func, bold = true },

    -- Statements
    Statement = { fg = s.keyword, bold = true },
    Conditional = { fg = s.keyword, bold = true },
    Repeat = { fg = s.keyword, bold = true },
    Label = { fg = s.keyword },
    Operator = { fg = s.operator },
    Keyword = { fg = s.keyword, bold = true },
    Exception = { fg = s.keyword, bold = true },

    -- Preprocessor
    PreProc = { fg = s.keyword },
    Include = { fg = s.keyword, bold = true },
    Define = { fg = s.keyword },
    Macro = { fg = s.keyword },
    PreCondit = { fg = s.keyword },

    -- Types
    Type = { fg = s.type, bold = true },
    StorageClass = { fg = s.keyword, bold = true },
    Structure = { fg = s.type, bold = true },
    Typedef = { fg = s.type, bold = true },

    -- Special
    Special = { fg = s.special },
    SpecialChar = { fg = s.escape },
    Tag = { fg = s.tag },
    Delimiter = { fg = s.punctuation },
    SpecialComment = { fg = s.comment, bold = true },
    Debug = { fg = p.warning_light },

    -- Underlined
    Underlined = { fg = p.info_light, underline = true },

    -- Ignore
    Ignore = { fg = p.dark300 },

    -- Error
    Error = { fg = p.error_light, bold = true },

    -- Todo
    Todo = { fg = p.gold500, bg = p.bg_element, bold = true },

    -- Added semantic groups
    Added = { fg = p.git.add },
    Changed = { fg = p.git.change },
    Removed = { fg = p.git.delete },
  }
end

return M

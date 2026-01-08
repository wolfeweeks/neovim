-- Boost colorscheme - Treesitter highlight groups
-- Modern semantic highlighting via nvim-treesitter

local M = {}

function M.get(p)
  local s = p.syntax

  return {
    -- Identifiers
    ["@variable"] = { fg = s.variable },
    ["@variable.builtin"] = { fg = s.variable, italic = true },
    ["@variable.parameter"] = { fg = s.parameter },
    ["@variable.parameter.builtin"] = { fg = s.parameter, italic = true },
    ["@variable.member"] = { fg = s.field },

    -- Constants
    ["@constant"] = { fg = s.constant, bold = true },
    ["@constant.builtin"] = { fg = s.constant, bold = true, italic = true },
    ["@constant.macro"] = { fg = s.constant },

    -- Modules/Namespaces
    ["@module"] = { fg = s.namespace },
    ["@module.builtin"] = { fg = s.namespace, italic = true },
    ["@label"] = { fg = s.keyword },

    -- Strings
    ["@string"] = { fg = s.string },
    ["@string.documentation"] = { fg = s.string },
    ["@string.regexp"] = { fg = s.regex },
    ["@string.escape"] = { fg = s.escape, bold = true },
    ["@string.special"] = { fg = s.special },
    ["@string.special.symbol"] = { fg = s.constant },
    ["@string.special.path"] = { fg = s.string, underline = true },
    ["@string.special.url"] = { fg = p.info_light, underline = true },

    -- Characters
    ["@character"] = { fg = s.string },
    ["@character.special"] = { fg = s.escape },

    -- Booleans
    ["@boolean"] = { fg = s.constant, bold = true },

    -- Numbers
    ["@number"] = { fg = s.number },
    ["@number.float"] = { fg = s.number },

    -- Types
    ["@type"] = { fg = s.type, bold = true },
    ["@type.builtin"] = { fg = s.type, bold = true, italic = true },
    ["@type.definition"] = { fg = s.type, bold = true },
    ["@type.qualifier"] = { fg = s.keyword, bold = true },

    -- Attributes/Annotations
    ["@attribute"] = { fg = s.attribute },
    ["@attribute.builtin"] = { fg = s.attribute, italic = true },
    ["@property"] = { fg = s.property },

    -- Functions
    ["@function"] = { fg = s.func, bold = true },
    ["@function.builtin"] = { fg = s.func, bold = true, italic = true },
    ["@function.call"] = { fg = s.func },
    ["@function.macro"] = { fg = s.func, bold = true },
    ["@function.method"] = { fg = s.func, bold = true },
    ["@function.method.call"] = { fg = s.func },

    -- Constructors
    ["@constructor"] = { fg = s.constructor, bold = true },

    -- Operators
    ["@operator"] = { fg = s.operator },

    -- Keywords
    ["@keyword"] = { fg = s.keyword, bold = true },
    ["@keyword.coroutine"] = { fg = s.keyword, bold = true },
    ["@keyword.function"] = { fg = s.keyword, bold = true },
    ["@keyword.operator"] = { fg = s.keyword },
    ["@keyword.import"] = { fg = s.keyword, bold = true },
    ["@keyword.type"] = { fg = s.keyword, bold = true },
    ["@keyword.modifier"] = { fg = s.keyword, bold = true },
    ["@keyword.repeat"] = { fg = s.keyword, bold = true },
    ["@keyword.return"] = { fg = s.keyword, bold = true },
    ["@keyword.debug"] = { fg = p.warning_light },
    ["@keyword.exception"] = { fg = s.keyword, bold = true },
    ["@keyword.conditional"] = { fg = s.keyword, bold = true },
    ["@keyword.conditional.ternary"] = { fg = s.operator },
    ["@keyword.directive"] = { fg = s.keyword },
    ["@keyword.directive.define"] = { fg = s.keyword },

    -- Punctuation
    ["@punctuation.bracket"] = { fg = s.punctuation },
    ["@punctuation.delimiter"] = { fg = s.punctuation },
    ["@punctuation.special"] = { fg = s.special },

    -- Comments
    ["@comment"] = { fg = s.comment, italic = true },
    ["@comment.documentation"] = { fg = s.comment, italic = true },
    ["@comment.error"] = { fg = p.error_light, bg = p.error_bg, bold = true },
    ["@comment.warning"] = { fg = p.warning_light, bg = p.warning_bg, bold = true },
    ["@comment.todo"] = { fg = p.gold500, bg = p.bg_element, bold = true },
    ["@comment.note"] = { fg = p.info_light, bg = p.info_bg, bold = true },

    -- Markup (Markdown, etc.)
    ["@markup"] = { fg = p.fg },
    ["@markup.strong"] = { fg = p.gold300, bold = true },
    ["@markup.italic"] = { fg = p.warning_light, italic = true },
    ["@markup.strikethrough"] = { fg = p.fg_muted, strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = p.gold500, bold = true },
    ["@markup.heading.1"] = { fg = p.gold500, bold = true },
    ["@markup.heading.2"] = { fg = p.gold400, bold = true },
    ["@markup.heading.3"] = { fg = p.gold300, bold = true },
    ["@markup.heading.4"] = { fg = p.gold200, bold = true },
    ["@markup.heading.5"] = { fg = p.gold100, bold = true },
    ["@markup.heading.6"] = { fg = p.gold50, bold = true },
    ["@markup.quote"] = { fg = p.dark100, italic = true },
    ["@markup.math"] = { fg = s.number },
    ["@markup.environment"] = { fg = s.keyword },
    ["@markup.link"] = { fg = p.info_light, underline = true },
    ["@markup.link.label"] = { fg = p.gold300 },
    ["@markup.link.url"] = { fg = p.info_light, underline = true },
    ["@markup.raw"] = { fg = p.gold400 },
    ["@markup.raw.block"] = { fg = p.fg },
    ["@markup.list"] = { fg = p.gold500 },
    ["@markup.list.checked"] = { fg = p.success_light },
    ["@markup.list.unchecked"] = { fg = p.fg_muted },

    -- Diff
    ["@diff.plus"] = { fg = p.git.add },
    ["@diff.minus"] = { fg = p.git.delete },
    ["@diff.delta"] = { fg = p.git.change },

    -- Tags (HTML, JSX, etc.)
    ["@tag"] = { fg = s.tag, bold = true },
    ["@tag.builtin"] = { fg = s.tag, bold = true, italic = true },
    ["@tag.attribute"] = { fg = s.attribute },
    ["@tag.delimiter"] = { fg = s.punctuation },

    -- Misc
    ["@none"] = {},
    ["@conceal"] = { fg = p.dark200 },

    -- Language-specific overrides
    -- Lua
    ["@lsp.typemod.variable.global.lua"] = { fg = s.variable, italic = true },

    -- Python
    ["@attribute.python"] = { fg = s.attribute },

    -- YAML
    ["@property.yaml"] = { fg = s.keyword },

    -- JSON
    ["@property.json"] = { fg = s.keyword },

    -- TOML
    ["@property.toml"] = { fg = s.keyword },

    -- CSS
    ["@property.css"] = { fg = s.property },
    ["@string.css"] = { fg = s.string },
    ["@number.css"] = { fg = s.number },

    -- Bash
    ["@function.builtin.bash"] = { fg = s.func, italic = true },
  }
end

return M

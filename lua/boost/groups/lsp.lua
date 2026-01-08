-- Boost colorscheme - LSP & Diagnostics highlight groups

local M = {}

function M.get(p)
  return {
    -- Diagnostics base
    DiagnosticError = { fg = p.error_light },
    DiagnosticWarn = { fg = p.warning_light },
    DiagnosticInfo = { fg = p.info_light },
    DiagnosticHint = { fg = p.hint },
    DiagnosticOk = { fg = p.success_light },

    -- Diagnostics virtual text
    DiagnosticVirtualTextError = { fg = p.error_light, bg = p.error_bg },
    DiagnosticVirtualTextWarn = { fg = p.warning_light, bg = p.warning_bg },
    DiagnosticVirtualTextInfo = { fg = p.info_light, bg = p.info_bg },
    DiagnosticVirtualTextHint = { fg = p.hint, bg = p.hint_bg },
    DiagnosticVirtualTextOk = { fg = p.success_light, bg = p.success_bg },

    -- Diagnostics underline
    DiagnosticUnderlineError = { sp = p.error_light, undercurl = true },
    DiagnosticUnderlineWarn = { sp = p.warning_light, undercurl = true },
    DiagnosticUnderlineInfo = { sp = p.info_light, undercurl = true },
    DiagnosticUnderlineHint = { sp = p.hint, undercurl = true },
    DiagnosticUnderlineOk = { sp = p.success_light, undercurl = true },

    -- Diagnostics floating
    DiagnosticFloatingError = { fg = p.error_light },
    DiagnosticFloatingWarn = { fg = p.warning_light },
    DiagnosticFloatingInfo = { fg = p.info_light },
    DiagnosticFloatingHint = { fg = p.hint },
    DiagnosticFloatingOk = { fg = p.success_light },

    -- Diagnostics signs
    DiagnosticSignError = { fg = p.error_light },
    DiagnosticSignWarn = { fg = p.warning_light },
    DiagnosticSignInfo = { fg = p.info_light },
    DiagnosticSignHint = { fg = p.hint },
    DiagnosticSignOk = { fg = p.success_light },

    -- LSP references
    LspReferenceText = { bg = p.bg_element },
    LspReferenceRead = { bg = p.bg_element },
    LspReferenceWrite = { bg = p.bg_element, bold = true },

    -- LSP signature
    LspSignatureActiveParameter = { fg = p.gold500, bold = true, underline = true },

    -- LSP codelens
    LspCodeLens = { fg = p.fg_muted },
    LspCodeLensSeparator = { fg = p.border },

    -- LSP inlay hints
    LspInlayHint = { fg = p.dark100, bg = p.bg_elevated, italic = true },

    -- LSP info window
    LspInfoBorder = { fg = p.border },

    -- LSP semantic tokens (these extend/override treesitter)
    ["@lsp.type.class"] = { fg = p.syntax.type, bold = true },
    ["@lsp.type.comment"] = {}, -- defer to treesitter
    ["@lsp.type.decorator"] = { fg = p.syntax.attribute },
    ["@lsp.type.enum"] = { fg = p.syntax.type, bold = true },
    ["@lsp.type.enumMember"] = { fg = p.syntax.constant },
    ["@lsp.type.event"] = { fg = p.syntax.type },
    ["@lsp.type.function"] = { fg = p.syntax.func, bold = true },
    ["@lsp.type.interface"] = { fg = p.syntax.type, bold = true },
    ["@lsp.type.keyword"] = { fg = p.syntax.keyword, bold = true },
    ["@lsp.type.macro"] = { fg = p.syntax.func },
    ["@lsp.type.method"] = { fg = p.syntax.func, bold = true },
    ["@lsp.type.modifier"] = { fg = p.syntax.keyword },
    ["@lsp.type.namespace"] = { fg = p.syntax.namespace },
    ["@lsp.type.number"] = { fg = p.syntax.number },
    ["@lsp.type.operator"] = { fg = p.syntax.operator },
    ["@lsp.type.parameter"] = { fg = p.syntax.parameter },
    ["@lsp.type.property"] = { fg = p.syntax.property },
    ["@lsp.type.regexp"] = { fg = p.syntax.regex },
    ["@lsp.type.string"] = { fg = p.syntax.string },
    ["@lsp.type.struct"] = { fg = p.syntax.type, bold = true },
    ["@lsp.type.type"] = { fg = p.syntax.type, bold = true },
    ["@lsp.type.typeParameter"] = { fg = p.syntax.type },
    ["@lsp.type.variable"] = {}, -- defer to treesitter

    -- LSP semantic modifiers
    ["@lsp.mod.abstract"] = { italic = true },
    ["@lsp.mod.async"] = { italic = true },
    ["@lsp.mod.declaration"] = { bold = true },
    ["@lsp.mod.defaultLibrary"] = { italic = true },
    ["@lsp.mod.definition"] = { bold = true },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.documentation"] = { italic = true },
    ["@lsp.mod.modification"] = {},
    ["@lsp.mod.readonly"] = { italic = true },
    ["@lsp.mod.static"] = { bold = true },

    -- LSP type + modifier combinations
    ["@lsp.typemod.function.defaultLibrary"] = { fg = p.syntax.func, bold = true, italic = true },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = p.syntax.variable, italic = true },
    ["@lsp.typemod.variable.readonly"] = { fg = p.syntax.constant, italic = true },
    ["@lsp.typemod.parameter.readonly"] = { fg = p.syntax.parameter, italic = true },
    ["@lsp.typemod.property.readonly"] = { fg = p.syntax.property, italic = true },
    ["@lsp.typemod.method.defaultLibrary"] = { fg = p.syntax.func, bold = true, italic = true },
  }
end

return M

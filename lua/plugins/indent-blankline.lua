return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function()
    local hooks = require("ibl.hooks")
    
    -- Rainbow colors for regular indent lines (no white)
    local highlight = {
      "IndentRainbow1",
      "IndentRainbow2", 
      "IndentRainbow3",
      "IndentRainbow4",
      "IndentRainbow5",
      "IndentRainbow6",
    }
    
    -- Create the highlight groups in the highlight setup hook
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- White for scope only
      vim.api.nvim_set_hl(0, "IndentScope", { fg = "#F5E6E0" })  -- Bright white from your theme
      
      -- Dimmer rainbow colors for regular indent lines
      vim.api.nvim_set_hl(0, "IndentRainbow1", { fg = "#64342F" })  -- Dimmer coral
      vim.api.nvim_set_hl(0, "IndentRainbow2", { fg = "#725843" })  -- Dimmer amber
      vim.api.nvim_set_hl(0, "IndentRainbow3", { fg = "#475E4E" })  -- Dimmer mint
      vim.api.nvim_set_hl(0, "IndentRainbow4", { fg = "#454862" })  -- Dimmer lavender
      vim.api.nvim_set_hl(0, "IndentRainbow5", { fg = "#5F3544" })  -- Dimmer mauve
      vim.api.nvim_set_hl(0, "IndentRainbow6", { fg = "#52546C" })  -- Dimmer periwinkle
    end)
    
    return {
      indent = {
        -- Use rainbow colors for the vertical lines
        char = "▏",
        highlight = highlight,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        char = "▏",
        highlight = "IndentScope",  -- Use white for scope only
      },
    }
  end,
}

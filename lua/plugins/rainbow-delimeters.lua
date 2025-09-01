return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    -- Define the highlight groups to match your dawn-sky theme
    local highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterOrange',
      'RainbowDelimiterYellow',
      'RainbowDelimiterGreen',
      'RainbowDelimiterBlue',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    }
    
    -- Set up the highlight groups with your dawn-sky colors
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Using the same bright colors from your theme
        vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#D26473' })     -- Coral red
        vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#FA9476' })  -- Bright orange
        vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5B085' })  -- Warm amber
        vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#8EBD9C' })   -- Mint green
        vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#8B90C4' })    -- Soft lavender
        vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#BE6B88' })  -- Mauve pink
        vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#A5A8D8' })    -- Periwinkle
      end
    })
    
    -- Trigger the autocmd to set colors immediately
    vim.cmd('doautocmd ColorScheme')
    
    local rainbow_delimiters = require('rainbow-delimiters')
    
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',  -- For Lua, highlight entire blocks
        tsx = 'rainbow-parens',
        javascript = 'rainbow-parens',
        typescript = 'rainbow-parens',
        html = 'rainbow-delimiters',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = highlight,
    }
  end,
}

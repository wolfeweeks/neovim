-- Colorscheme configuration
-- Sets 'github' as the default colorscheme

return {
  -- Disable LazyVim's default tokyonight
  { "folke/tokyonight.nvim", enabled = false },

  -- Load github colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github",
    },
  },

  -- Update lualine theme when custom colorschemes are activated
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "github",
        callback = function()
          require("lualine").setup({
            options = { theme = require("github").lualine() },
          })
        end,
      })
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "boost",
        callback = function()
          require("lualine").setup({
            options = { theme = require("boost").lualine() },
          })
        end,
      })
      return opts
    end,
  },
}

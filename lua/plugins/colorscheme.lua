-- Colorscheme configuration
-- The 'boost' colorscheme is available but not set as default
-- Use .nvim.lua in project directories to enable it locally

return {
  -- Update lualine theme when boost colorscheme is activated
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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

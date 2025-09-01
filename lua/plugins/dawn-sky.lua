return {
  {
    dir = vim.fn.stdpath("config") .. "/colors",
    name = 'dawn-sky',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme dawn-sky')
    end,
  }
}

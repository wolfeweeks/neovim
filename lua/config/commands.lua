-- Always disable line wrap in normal file buffers
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.opt_local.wrap = false
  end,
})


-- Set leaders *before* anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic UI niceties you likely want
vim.opt.termguicolors = true

-- Hand off to our structured lazy.nvim setup
require("config.lazy")

require("config.after.nvim-tree")

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings: 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- number of spaces when indenting with >>
vim.opt.tabstop = 2 -- number of spaces a <Tab> counts for
vim.opt.softtabstop = 2 -- number of spaces a <Tab> counts for while editing

vim.opt.equalalways = false -- stop Vim from auto-equalizing split sizes

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Smarter searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- Splits & UI polish
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Persistent undo across restarts
vim.opt.undofile = true

-- Draw clear lines between windows (vertical & horizontal)
vim.opt.fillchars:append({
	vert = "│",
	vertleft = "├",
	vertright = "┤",
	verthoriz = "┼",
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	eob = " ", -- hide ~ at end of buffer
})

-- Keep the single global statusline and show a small title per window
vim.opt.laststatus = 3
vim.opt.winbar = " %t %m" -- file name + modified flag

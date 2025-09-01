-- Global mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Move between splits more easily
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Move current line up/down in NORMAL mode
map("n", "<A-j>", ":m .+1<CR>==", opts)  -- Alt/Option + j = move line down
map("n", "<A-k>", ":m .-2<CR>==", opts)  -- Alt/Option + k = move line up

-- Move selected lines up/down in VISUAL mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Recenter cursor after page moves
map("n", "<leader>j", "<C-d>zz", opts)
map("n", "<leader>k", "<C-u>zz", opts)

map("n", "<C-a>", "gg0vG$l", opts)

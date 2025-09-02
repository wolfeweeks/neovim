-- File: lua/config/after/mini-diff.lua
local md = require("mini.diff")

md.setup({
	-- Make the normal view do nothing and never outrank gitsigns
	view = {
		style = "sign", -- use sign mode (so numbers aren't tinted)
		signs = { add = "", change = "", delete = "" }, -- empty signs => show nothing
		priority = 0, -- gitsigns has priority 6; this stays below
	},
	-- Disable all default mappings so gitsigns owns the UX
	mappings = {
		apply = "",
		reset = "",
		textobject = "",
		goto_first = "",
		goto_prev = "",
		goto_next = "",
		goto_last = "",
	},
	-- Keep defaults for the diff engine so overlay looks great when toggled
})

-- Your existing overlay toggle
vim.keymap.set("n", "<leader>gha", function()
	md.toggle_overlay()
end, { desc = "MiniDiff: overlay (toggle)" })

-- File: lua/plugins/nvim-autopairs.lua
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp", -- ensures cmp is loaded before this config runs
		"nvim-treesitter/nvim-treesitter", -- for check_ts behavior
	},
	config = function()
		local npairs = require("nvim-autopairs")

		-- Treesitter-aware autopairs
		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" }, -- don't add pairs inside TS string nodes
				javascript = { "template_string" },
				typescript = { "template_string" },
				-- java = false,                  -- example: disable TS checks for a filetype
			},
			-- You can tweak other defaults here if you want, e.g.:
			-- enable_check_bracket_line = true,
			-- ignored_next_char = "[%w%.]",
			-- fast_wrap = {},                 -- enable <M-e> fast wrap if you like
		})

		-- Robust nvim-cmp integration: add `()` after confirming function/method items, etc.
		local ok_cmp, cmp = pcall(require, "cmp")
		if ok_cmp then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}

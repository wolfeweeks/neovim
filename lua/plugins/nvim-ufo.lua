-- nvim-ufo: modern, fast folds with LSP/Treesitter providers
return {
	"kevinhwang91/nvim-ufo",
	event = "VeryLazy",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		--------------------------------------------------------------------------
		-- THEME HOOKS (Dawn Sky colors without touching your colorscheme file)
		--------------------------------------------------------------------------
		local function set_ufo_highlights()
			-- Use your palette:
			--   bg:   #1A1518 (your CursorLine/Folded bg)
			--   fg:   #F5E6E0 (Normal fg)
			--   accent for count/chevron: #BE6B88
			vim.api.nvim_set_hl(0, "UfoFoldedBg", { bg = "#1A1518" })
			vim.api.nvim_set_hl(0, "UfoFoldedFg", { fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { fg = "#9B7A94", italic = true }) -- subtle like Comment
			vim.api.nvim_set_hl(0, "UfoCursorFoldedLine", { bg = "#4A3A3D" }) -- your Visual-ish
			-- Custom group for the “↳N” badge
			vim.api.nvim_set_hl(0, "UfoFoldCount", { fg = "#BE6B88", bold = true })
			-- Make the fold gutter match your sidebar tone
			vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#564B48", bg = "#090909" })
		end

		-- Re-apply highlights whenever colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_ufo_highlights })
		set_ufo_highlights()

		--------------------------------------------------------------------------
		-- PRETTY FOLD TEXT (shows code snippet + “↳N” lines badge)
		--------------------------------------------------------------------------
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local new = {}
			local count = endLnum - lnum
			local suffix = ("  ↳%d "):format(count)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0

			for _, chunk in ipairs(virtText) do
				local chunkText, hl = chunk[1], chunk[2]
				local w = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + w then
					table.insert(new, { chunkText, hl })
					curWidth = curWidth + w
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					table.insert(new, { chunkText, hl })
					curWidth = targetWidth
					break
				end
			end

			table.insert(new, { suffix, "UfoFoldCount" }) -- themed badge
			return new
		end

		--------------------------------------------------------------------------
		-- UFO SETUP (Treesitter first; auto-close imports & comments)
		--------------------------------------------------------------------------
		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,

			-- Close “noise” folds after a buffer first appears
			-- (You can add per-filetype tweaks here anytime)
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array", "object" }, -- handy for big JSON
				markdown = {}, -- keep MD open
			},

			-- Keep the current line’s fold open on first display (more friendly)
			close_fold_current_line_for_ft = { default = false },

			fold_virt_text_handler = handler,

			preview = {
				win_config = {
					border = "rounded",
					winblend = 0,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
					maxheight = 20,
				},
			},
		})

		--------------------------------------------------------------------------
		-- KEYMAPS (unchanged, just here for completeness)
		--------------------------------------------------------------------------
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: close all folds" })
		vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "UFO: open folds (smart)" })
		vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "UFO: close folds (level)" })

		-- Peek folded lines; if not on a fold, fall back to LSP hover
		vim.keymap.set("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid and vim.lsp.buf.hover then
				vim.lsp.buf.hover()
			end
		end, { desc = "UFO: peek fold / LSP hover" })
	end,
}

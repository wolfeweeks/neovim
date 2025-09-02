-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- If you try to :q the *last* window (and it's not NvimTree), open NvimTree instead.
-- If you're already in NvimTree, :q will quit Neovim as usual.
local aug = vim.api.nvim_create_augroup("LastQuitOpensTree", { clear = true })

vim.api.nvim_create_autocmd("QuitPre", {
	group = aug,
	callback = function()
		-- only act when this tab has exactly one window
		if vim.fn.winnr("$") ~= 1 then
			return
		end

		-- let :q actually quit when you're in NvimTree
		if vim.bo.filetype == "NvimTree" then
			return
		end

		-- open the tree without stealing focus (so :q just closes the current window)
		local ok, api = pcall(require, "nvim-tree.api")
		if not ok then
			return
		end

		local curwin = vim.api.nvim_get_current_win()
		api.tree.open() -- creates the tree window
		pcall(vim.api.nvim_set_current_win, curwin) -- stay on the window you’re quitting
	end,
})

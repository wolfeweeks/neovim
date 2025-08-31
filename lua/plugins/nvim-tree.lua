return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("nvim-tree").setup({
				view = { side = "right", width = 40 },
				renderer = { 
					group_empty = true,
					root_folder_label = false,
				},
				filters = { dotfiles = false },
				git = { enable = true },
				hijack_directories = {
					enable = true,
					auto_open = true,
				},
			})

			-- Open nvim-tree if opening a directory
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					local directory = vim.fn.isdirectory(data.file) == 1
					if directory then
						require("nvim-tree.api").tree.open()
					end
				end
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
		},
	},
}


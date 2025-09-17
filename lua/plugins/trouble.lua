return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		-- VS Code-like Problems panel toggle (Ctrl+Shift+M in VS Code)
		{ "<leader>xp", "<cmd>Trouble diagnostics toggle<cr>", desc = "Problems Panel (Trouble)" },
		{ "<C-S-m>", "<cmd>Trouble diagnostics toggle<cr>", desc = "Problems Panel (Trouble)" },

		-- Quick diagnostic navigation (matches VS Code F8/Shift+F8)
		{
			"<F8>",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					vim.diagnostic.goto_next()
				end
			end,
			desc = "Next Diagnostic",
		},
		{
			"<S-F8>",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					vim.diagnostic.goto_prev()
				end
			end,
			desc = "Previous Diagnostic",
		},

		-- Buffer-specific diagnostics (like VS Code's "Show problems for current file")
		{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Problems (Trouble)" },

		-- Document symbols (like VS Code's Outline view)
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle focus=false win.position=right<cr>",
			desc = "Document Symbols (Trouble)",
		},

		-- LSP references/definitions (complements your existing LSP keymaps)
		{ "gr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
		{ "gI", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "LSP Implementations (Trouble)" },
		{ "gy", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "Type Definitions (Trouble)" },

		-- Quickfix and Location list integration
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },

		-- Telescope integration (since you use Telescope)
		{ "<leader>xt", "<cmd>Trouble telescope toggle<cr>", desc = "Telescope Results (Trouble)" },
	},
	opts = {
		-- VS Code-like behavior
		auto_close = false, -- Don't auto close when no items (VS Code keeps it open)
		auto_open = false, -- Set to true if you want auto-open on errors like VS Code
		auto_preview = true, -- Show preview of diagnostic like VS Code
		auto_refresh = true, -- Keep diagnostics updated in real-time
		auto_jump = false, -- Don't auto jump (VS Code doesn't)
		focus = false, -- Don't steal focus when opened (like VS Code)
		restore = true, -- Remember position in list
		follow = true, -- Follow current item
		indent_guides = true, -- Show indent guides
		max_items = 500, -- VS Code shows more items
		multiline = true, -- Show full diagnostic messages
		pinned = false, -- Not pinned by default
		warn_no_results = false, -- VS Code doesn't warn
		open_no_results = false, -- Don't open if empty

		-- VS Code-style bottom panel (Problems window)
		win = {
			type = "split",
			position = "bottom",
			size = 10, -- 10 lines tall (adjustable)
			relative = "editor", -- Relative to whole editor, not window
		},

		-- Preview configuration (matches VS Code hover behavior)
		preview = {
			type = "main", -- Show preview in main editor
			scratch = true,
		},

		-- Keymaps within Trouble window (VS Code-like)
		keys = {
			["?"] = "help",
			r = "refresh",
			R = "toggle_refresh",
			q = "close",
			["<esc>"] = "close", -- ESC closes like VS Code
			o = "jump", -- Keep trouble open
			["<cr>"] = "jump_close", -- Enter jumps and closes like VS Code
			["<2-leftmouse>"] = "jump",
			["<c-x>"] = "jump_split", -- Open in horizontal split
			["<c-v>"] = "jump_vsplit", -- Open in vertical split
			["<c-t>"] = "jump_tab", -- Open in new tab

			-- VS Code-like navigation
			j = "next",
			k = "prev",
			["<down>"] = "next",
			["<up>"] = "prev",
			["<tab>"] = "next",
			["<s-tab>"] = "prev",

			-- Folding (like VS Code's collapsible sections)
			["<space>"] = "fold_toggle",
			zo = "fold_open",
			zc = "fold_close",
			za = "fold_toggle",
			zM = "fold_close_all",
			zR = "fold_open_all",

			-- Filter toggles
			e = {
				action = function(view)
					-- Toggle error filter
					local f = view:get_filter("severity")
					local severity = vim.diagnostic.severity.ERROR
					view:filter({ severity = severity }, {
						id = "severity",
						template = "{hl:DiagnosticError}Errors only{hl}",
						del = f and f.filter.severity == severity,
					})
				end,
				desc = "Toggle Errors Only",
			},
			w = {
				action = function(view)
					-- Toggle warning filter
					local f = view:get_filter("severity")
					local severity = vim.diagnostic.severity.WARN
					view:filter({ severity = severity }, {
						id = "severity",
						template = "{hl:DiagnosticWarn}Warnings only{hl}",
						del = f and f.filter.severity == severity,
					})
				end,
				desc = "Toggle Warnings Only",
			},
			f = {
				action = function(view)
					-- Toggle current file filter
					view:filter({ buf = 0 }, { toggle = true })
				end,
				desc = "Toggle Current File Filter",
			},

			-- Clear/Delete diagnostics (if supported by source)
			dd = "delete",
			d = { action = "delete", mode = "v" },

			-- Inspect for debugging
			i = "inspect",

			-- Preview toggle
			p = "preview",
			P = "toggle_preview",
		},

		-- Custom modes configuration
		modes = {
			-- Main diagnostics mode (VS Code Problems panel)
			diagnostics = {
				mode = "diagnostics",
				win = {
					type = "split",
					position = "bottom",
					size = 10,
				},
				preview = {
					type = "main",
					scratch = true,
				},
				groups = {
					{ "filename", format = "{file_icon} {filename} {count}" },
				},
				sort = { "severity", "filename", "pos" },
				format = "{severity_icon} [{code}] {message} {pos}",
			},

			-- Document symbols (VS Code Outline)
			symbols = {
				mode = "lsp_document_symbols",
				focus = false,
				win = {
					type = "split",
					position = "right",
					size = 30,
				},
				filter = {
					-- Filter out less important symbols
					["not"] = { kind = "Package" },
					any = {
						ft = { "help", "markdown" },
						kind = {
							"Class",
							"Constructor",
							"Enum",
							"Field",
							"Function",
							"Interface",
							"Method",
							"Module",
							"Namespace",
							"Property",
							"Struct",
							"Variable",
						},
					},
				},
			},

			-- Quickfix mode
			quickfix = {
				mode = "quickfix",
				focus = true,
				win = {
					type = "split",
					position = "bottom",
					size = 10,
				},
			},

			-- LSP references
			lsp_references = {
				params = {
					include_declaration = false, -- Don't include the declaration itself
				},
			},
		},

		-- Icons configuration (using Nerd Fonts like your setup)
		icons = {
			indent = {
				top = "│ ",
				middle = "├╴",
				last = "└╴",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				-- VS Code-like icons
				Array = " ",
				Boolean = " ",
				Class = " ",
				Constant = " ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Function = " ",
				Interface = " ",
				Key = " ",
				Method = " ",
				Module = " ",
				Namespace = " ",
				Null = "󰟢 ",
				Number = " ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				String = " ",
				Struct = " ",
				TypeParameter = " ",
				Variable = " ",
			},
		},
	},
	config = function(_, opts)
		require("trouble").setup(opts)

		-- Dawn Sky theme integration
		local function set_trouble_highlights()
			-- Use your dawn-sky palette
			vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "#0E0C0C", fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "#0E0C0C", fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "TroubleText", { fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "TroubleCount", { bg = "#BE6B88", fg = "#090909", bold = true })
			vim.api.nvim_set_hl(0, "TroublePreview", { bg = "#4A3A3D" })

			-- File and directory colors
			vim.api.nvim_set_hl(0, "TroubleFilename", { fg = "#BE6B88" })
			vim.api.nvim_set_hl(0, "TroubleDirectory", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleBasename", { fg = "#F5E6E0", bold = true })

			-- Source and position info
			vim.api.nvim_set_hl(0, "TroubleSource", { fg = "#9B7A94", italic = true })
			vim.api.nvim_set_hl(0, "TroublePos", { fg = "#6B70A4" })
			vim.api.nvim_set_hl(0, "TroubleCode", { fg = "#FA9476" })

			-- Indent guides
			vim.api.nvim_set_hl(0, "TroubleIndent", { fg = "#2A201E" })
			vim.api.nvim_set_hl(0, "TroubleIndentFoldOpen", { fg = "#564B48" })
			vim.api.nvim_set_hl(0, "TroubleIndentFoldClosed", { fg = "#BE6B88" })

			-- Icon colors matching dawn-sky
			vim.api.nvim_set_hl(0, "TroubleIconDirectory", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconFile", { fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "TroubleIconModule", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconNamespace", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconPackage", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconClass", { fg = "#BE6B88" })
			vim.api.nvim_set_hl(0, "TroubleIconMethod", { fg = "#BE6B88" })
			vim.api.nvim_set_hl(0, "TroubleIconFunction", { fg = "#BE6B88" })
			vim.api.nvim_set_hl(0, "TroubleIconConstructor", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconField", { fg = "#D090A8" })
			vim.api.nvim_set_hl(0, "TroubleIconVariable", { fg = "#F5E6E0" })
			vim.api.nvim_set_hl(0, "TroubleIconInterface", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconConstant", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconString", { fg = "#E88D8E" })
			vim.api.nvim_set_hl(0, "TroubleIconNumber", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconBoolean", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconArray", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconObject", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconKey", { fg = "#FA9476" })
			vim.api.nvim_set_hl(0, "TroubleIconNull", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconEnum", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconEnumMember", { fg = "#C18496" })
			vim.api.nvim_set_hl(0, "TroubleIconStruct", { fg = "#9E658D" })
			vim.api.nvim_set_hl(0, "TroubleIconEvent", { fg = "#FA9476" })
			vim.api.nvim_set_hl(0, "TroubleIconOperator", { fg = "#D090A8" })
			vim.api.nvim_set_hl(0, "TroubleIconTypeParameter", { fg = "#8B90C4" })
			vim.api.nvim_set_hl(0, "TroubleIconProperty", { fg = "#D090A8" })
		end

		-- Apply highlights on colorscheme change
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "dawn-sky",
			callback = set_trouble_highlights,
		})

		-- Apply immediately if dawn-sky is already active
		if vim.g.colors_name == "dawn_sky" then
			set_trouble_highlights()
		end

		-- Optional: Auto-open trouble when there are diagnostics (VS Code-like)
		-- Uncomment the following to enable:
		--[[
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function()
        local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        if #diagnostics > 0 and not require("trouble").is_open() then
          vim.cmd("Trouble diagnostics open")
        end
      end,
    })
    --]]

		-- Integration with Telescope (since you use it)
		local ok, telescope = pcall(require, "telescope")
		if ok then
			local open_with_trouble = require("trouble.sources.telescope").open
			local add_to_trouble = require("trouble.sources.telescope").add

			-- You can add this to your telescope config or here
			-- This adds <c-t> to open telescope results in trouble
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopePreviewerLoaded",
				callback = function()
					vim.keymap.set("i", "<c-t>", open_with_trouble, { buffer = true })
					vim.keymap.set("n", "<c-t>", open_with_trouble, { buffer = true })
					vim.keymap.set("i", "<c-a>", add_to_trouble, { buffer = true })
					vim.keymap.set("n", "<c-a>", add_to_trouble, { buffer = true })
				end,
			})
		end
	end,
}

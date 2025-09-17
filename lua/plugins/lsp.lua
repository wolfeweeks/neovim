return {
	-- Mason (new org name is optional but recommended)
	{ "mason-org/mason.nvim", opts = {} },

	-- Bridge Mason <-> LSP. It will auto-enable installed servers.
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = { "lua_ls", "vtsls", "bashls", "jsonls", "marksman" },
			-- leave automatic_enable = true (default)
		},
	},

	-- Core LSP + your keymaps/capabilities the new way
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- 1) Diagnostics UI (unchanged)
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			-- 2) Default capabilities (for nvim-cmp, etc.)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			-- ✨ Add folding capability for UFO (not enabled by default in Neovim)
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- apply to *all* servers
			vim.lsp.config("*", { capabilities = capabilities }) -- Neovim 0.11+

			-- 3) Server-specific tweaks (example: Lua)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- 4) Your LSP keymaps — bind whenever any server attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local bufnr = ev.buf
					local map = function(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "goto definition")
					map("gr", vim.lsp.buf.references, "references")
					map("K", vim.lsp.buf.hover, "hover docs")
					map("<leader>rn", vim.lsp.buf.rename, "rename")
					map("<leader>ca", vim.lsp.buf.code_action, "code action")
					map("[d", vim.diagnostic.goto_prev, "prev diagnostic")
					map("]d", vim.diagnostic.goto_next, "next diagnostic")
					map("<leader>d", vim.diagnostic.open_float, "show diagnostic")
					map("<leader>q", vim.diagnostic.setloclist, "diagnostics to location list")
				end,
			})
		end,
	},

	-- Completion (your existing block is fine)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp, luasnip = require("cmp"), require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping(function(fb)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fb()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fb)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fb()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
		end,
	},
}

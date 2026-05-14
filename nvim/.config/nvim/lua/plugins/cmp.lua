return {
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			-- Collection of pre-made snippets for many languages
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")

			-- Load VSCode-style snippets from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			ls.config.set_config({
				history = true, -- allow jumping back into previous snippets
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = false,
			})

			-- Jump forward through snippet tabstops
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if ls.jumpable(1) then
					ls.jump(1)
				end
			end, { silent = true, desc = "LuaSnip: jump forward" })

			-- Jump backward through snippet tabstops
			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true, desc = "LuaSnip: jump backward" })

			-- Cycle through choices in a choiceNode
			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip: next choice" })
		end,
	},

	-- cmp_luasnip: bridges LuaSnip with nvim-cmp
	{ "saadparwaiz1/cmp_luasnip" },

	-- cmp-nvim-lsp: feeds LSP completions into nvim-cmp
	{ "hrsh7th/cmp-nvim-lsp" },

	-- Additional useful sources
	{ "hrsh7th/cmp-buffer" }, -- completions from current buffer text
	{ "hrsh7th/cmp-path" }, -- filesystem path completions

	-- The main completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					-- Navigate completion menu
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),

					-- Scroll docs in the documentation window
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Manually trigger completion
					["<C-Space>"] = cmp.mapping.complete(),

					-- Close completion menu
					["<C-c>"] = cmp.mapping.abort(),

					-- Confirm selection
					-- select = false means only confirm if you explicitly selected an item
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					-- Smart Tab: Copilot → cmp → luasnip → fallback
					["<Tab>"] = cmp.mapping(function(fallback)
						local copilot_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
						if copilot_ok and copilot_suggestion.is_visible() then
							copilot_suggestion.accept()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),

				-- Show completion item kinds with icons
				formatting = {
					format = function(entry, item)
						local kind_icons = {
							Text = "",
							Class = "",
							Function = "",
							Interface = "",
							Constructor = "",
							Module = "",
							Field = "",
							Property = "",
							Variable = "",
							Unit = "",
							Value = "",
							Enum = "",
							Keyword = "",
							EnumMember = "",
							Snippet = "",
							Constant = "",
							Color = "",
							File = "",
							Reference = "",
							Folder = "",
							Event = "",
							Operator = "",
							Method = "",
							TypeParameter = "",
							Struct = "",
						}
						item.kind = string.format("%s %s", kind_icons[item.kind] or "", item.kind)
						item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							buffer = "[Buf]",
							path = "[Path]",
						})[entry.source.name]
						return item
					end,
				},

				-- Don't show completion in comments
				enabled = function()
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
			})
		end,
	},
}

-- Change this to switch themes:
-- "dracula" | "catppuccin" | "tokyonight" | "kanagawa" | "rose-pine" | "everforest"
local active = "everforest"

-- Lualine theme names for each colorscheme
local lualine_themes = {
	dracula = "dracula-nvim",
	catppuccin = "catppuccin",
	tokyonight = "tokyonight",
	kanagawa = "kanagawa",
	["rose-pine"] = "rose-pine",
	everforest = "everforest",
}

-- Make the active lualine theme available globally so lualine.lua can read it
vim.g.active_lualine_theme = lualine_themes[active]

return {
	-- =========================================================================
	-- DRACULA
	-- =========================================================================
	{
		"Mofiqul/dracula.nvim",
		lazy = active ~= "dracula",
		priority = 1000,
		config = function()
			if active ~= "dracula" then
				return
			end
			require("dracula").setup({
				show_end_of_buffer = true,
				italic_comment = true,
				transparent_bg = true,
				overrides = function(colors)
					return {
						Normal = { bg = colors.bg },
						NormalNC = { bg = colors.bg },
						NormalFloat = { bg = colors.bg },
						SignColumn = { bg = colors.bg },
						EndOfBuffer = { bg = colors.bg },
					}
				end,
			})
			vim.cmd.colorscheme("dracula")
		end,
	},

	-- =========================================================================
	-- CATPPUCCIN
	-- variants: "latte" | "frappe" | "macchiato" | "mocha"
	-- =========================================================================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = active ~= "catppuccin",
		priority = 1000,
		config = function()
			if active ~= "catppuccin" then
				return
			end
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					treesitter = true,
					telescope = { enabled = true },
					neotree = true,
					bufferline = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- =========================================================================
	-- TOKYONIGHT
	-- styles: "storm" | "moon" | "night" | "day"
	-- =========================================================================
	{
		"folke/tokyonight.nvim",
		lazy = active ~= "tokyonight",
		priority = 1000,
		config = function()
			if active ~= "tokyonight" then
				return
			end
			require("tokyonight").setup({
				style = "moon",
				transparent = false,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					sidebars = "dark",
					floats = "dark",
				},
				lualine_bold = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- =========================================================================
	-- KANAGAWA
	-- themes: "wave" | "dragon" | "lotus"
	-- =========================================================================
	{
		"rebelot/kanagawa.nvim",
		lazy = active ~= "kanagawa",
		priority = 1000,
		config = function()
			if active ~= "kanagawa" then
				return
			end
			require("kanagawa").setup({
				theme = "wave", -- "wave" | "dragon" | "lotus"
				transparent = false,
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				terminalColors = true,
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- =========================================================================
	-- ROSE PINE
	-- variants: "main" | "moon" | "dawn"
	-- =========================================================================
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = active ~= "rose-pine",
		priority = 1000,
		config = function()
			if active ~= "rose-pine" then
				return
			end
			require("rose-pine").setup({
				variant = "main", -- "main" | "moon" | "dawn"
				dark_variant = "main",
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- =========================================================================
	-- EVERFOREST
	-- backgrounds: "hard" | "medium" | "soft"
	-- =========================================================================
	{
		"sainnhe/everforest",
		lazy = active ~= "everforest",
		priority = 1000,
		config = function()
			if active ~= "everforest" then
				return
			end
			-- Everforest uses vim.g globals, not a setup() call
			vim.g.everforest_background = "hard" -- "hard" | "medium" | "soft"
			vim.g.everforest_better_performance = 1
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_disable_italic_comment = 0
			vim.g.everforest_transparent_background = 0
			vim.o.background = "dark" -- "dark" | "light"
			vim.cmd.colorscheme("everforest")
		end,
	},
}

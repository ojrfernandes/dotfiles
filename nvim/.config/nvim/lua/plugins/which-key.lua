return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "helix",
			delay = 300, -- ms before popup appears
			icons = {
				mappings = true,
			},
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true, suggestions = 20 },
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
		})

		-- Register group names so the popup shows tidy labels
		wk.add({
			{ "<leader>f", group = "find (telescope)" },
			{ "<leader>g", group = "git / format" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>n", group = "neo-tree" },
			{ "<leader>c", group = "code (LSP)" },
			{ "<leader>r", group = "rename / remote" },
			{ "<leader>d", group = "diagnostics" },
			{ "<leader>cp", group = "copilot" },
		})
	end,
}

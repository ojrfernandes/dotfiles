return {
	{
		"startup-nvim/startup.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("startup").setup({
				header = {
					type = "text",
					align = "left",
					fold_section = false,
					title = "Header",
					margin = 5,
					content = {
						"                                                     ",
						"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
						"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
						"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
						"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
						"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
						"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
						"                                                     ",
					},
					highlight = "Statement",
					default_color = "",
					oldfiles_amount = 0,
				},

				datetime = {
					type = "text",
					align = "left",
					fold_section = false,
					title = "",
					margin = 5,
					content = function()
						local clock = "  " .. os.date("%H:%M")
						local date = "  " .. os.date("%A, %d %B %Y")
						return { clock, date }
					end,
					highlight = "Comment",
					default_color = "",
					oldfiles_amount = 0,
				},

				commands = {
					type = "mapping",
					align = "left",
					fold_section = false,
					title = "Commands",
					margin = 5,
					content = {
						{ "  Find File", "Telescope find_files", "<leader>ff" },
						{ "  Find Word", "Telescope live_grep", "<leader>fg" },
						{ "  Recent Files", "Telescope oldfiles", "<leader>fo" },
						{ "  File Browser", "Telescope file_browser", "<leader>fb" },
						{ "  New File", "lua require'startup'.new_file()", "<leader>nf" },
						{ "  Quit", "quit", "<leader>q" },
					},
					highlight = "String",
					default_color = "",
					oldfiles_amount = 0,
				},

				options = {
					mapping_keys = true,
					cursor_column = 0.5,
					empty_lines_between_mappings = true,
					disable_statuslines = true,
					paddings = { 2, 2, 2 },
				},

				mappings = {
					execute_command = "<CR>",
					open_file = "o",
					open_file_split = "<C-o>",
					open_section = "<TAB>",
					open_help = "?",
				},

				colors = {
					background = "#1f2227",
					folded_section = "#56b6c2",
				},

				parts = { "header", "datetime", "commands" },
			})
		end,
	},
}

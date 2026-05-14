return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true, -- shows suggestions as you type
					debounce = 75, -- ms delay before requesting suggestion
					keymap = {
						accept = false, -- accept full suggestion
						accept_word = "<C-Right>", -- accept one word at a time
						accept_line = "<C-Down>", -- accept one line at a time
						next = "<M-]>", -- next suggestion
						prev = "<M-[>", -- previous suggestion
						dismiss = "<C-]>", -- dismiss suggestion
					},
				},
				panel = { enabled = false }, -- we use inline suggestions, not the panel
				filetypes = {
					lua = true,
					python = true,
					c = true,
					cpp = true,
					rust = true,
					fortran = true,
					markdown = false,
					help = false,
					["*"] = false, -- disable for all other filetypes
				},
			})
			vim.keymap.set("n", "<leader>cpe", "<Cmd>Copilot enable<CR>", { desc = "Copilot: enable" })
			vim.keymap.set("n", "<leader>cpd", "<Cmd>Copilot disable<CR>", { desc = "Copilot: disable" })
			vim.keymap.set("n", "<leader>cps", "<Cmd>Copilot status<CR>", { desc = "Copilot: status" })
		end,
	},
}

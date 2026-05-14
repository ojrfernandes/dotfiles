return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-\>]],
			direction = "float", -- default: float terminal
			float_opts = {
				border = "curved",
				winblend = 3,
			},
			shade_terminals = true,
			start_in_insert = true,
			persist_mode = true,
		})

		-- Allow navigating out of the terminal with Ctrl+hjkl
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		-- Extra direction-specific toggles
		vim.keymap.set("n", "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", { desc = "Terminal: float" })
		vim.keymap.set(
			"n",
			"<leader>th",
			"<Cmd>ToggleTerm direction=horizontal<CR>",
			{ desc = "Terminal: horizontal split" }
		)
		vim.keymap.set(
			"n",
			"<leader>tv",
			"<Cmd>ToggleTerm direction=vertical<CR>",
			{ desc = "Terminal: vertical split" }
		)
	end,
}

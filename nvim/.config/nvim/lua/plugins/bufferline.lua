return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp", -- show LSP error/warning counts on tabs
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return icon .. count
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_buffer_close_icons = true,
				show_close_icon = false,
				separator_style = "thin",
			},
		})

		-- Buffer navigation
		vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Bufferline: prev buffer" })
		vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Bufferline: next buffer" })
		vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Bufferline: close buffer" })
		vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Bufferline: pin buffer" })
	end,
}

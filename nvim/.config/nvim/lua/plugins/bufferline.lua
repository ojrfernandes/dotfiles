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
		vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Bufferline: pin buffer" })
		vim.keymap.set("n", "<leader>bd", function()
			local current = vim.api.nvim_get_current_buf()
			-- Try to switch to the previous buffer first
			vim.cmd("bprevious")
			-- If we're still on the same buffer (no other buffers),
			-- create an empty one so the window survives
			if vim.api.nvim_get_current_buf() == current then
				vim.cmd("enew")
			end
			-- Now safely delete the original buffer
			vim.api.nvim_buf_delete(current, { force = false })
		end, { desc = "Bufferline: close buffer" })
	end,
}

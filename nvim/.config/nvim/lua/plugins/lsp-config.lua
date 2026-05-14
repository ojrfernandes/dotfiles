return {
	-- Mason: installs LSP servers, linters, formatters
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- mason-lspconfig: bridges Mason with vim.lsp.enable()
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig", -- must be in runtimepath before setup
		},
		config = function()
			require("mason-lspconfig").setup({
				-- Servers to auto-install if not already present
				ensure_installed = {
					"lua_ls", -- Lua
					"rust_analyzer", -- Rust
					"clangd", -- C and C++
					"pyright", -- Python
					"fortls", -- Fortran
				},
				-- automatic_enable = true is the default; mason-lspconfig
				-- will call vim.lsp.enable() for each installed server
			})
		end,
	},

	-- nvim-lspconfig: provides server-specific configs for vim.lsp
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Per-server custom configuration (extends the defaults from nvim-lspconfig)
			-- lua_ls needs to know about the vim global to avoid false warnings
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})

			-- Set up LSP keymaps only when an LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local buf = event.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end

					map("n", "K", vim.lsp.buf.hover, "LSP: hover docs")
					map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
					map("n", "gr", vim.lsp.buf.references, "LSP: references")
					map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename symbol")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
					map("n", "<leader>d", vim.diagnostic.open_float, "LSP: show diagnostics")
					map("n", "[d", vim.diagnostic.goto_prev, "LSP: prev diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "LSP: next diagnostic")
				end,
			})
		end,
	},
}

return {
	"nosduco/remote-sshfs.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("remote-sshfs").setup({
			connections = {
				ssh_configs = {
					vim.fn.expand("$HOME") .. "/.ssh/config",
					"/etc/ssh/ssh_config",
				},
				sshfs_args = {
					"-o reconnect",
					"-o ConnectTimeout=5",
				},
			},
			mounts = {
				base_dir = vim.fn.expand("$HOME") .. "/.sshfs/",
				unmount_on_exit = true, -- auto-unmount when nvim closes
			},
			handlers = {
				on_connect = {
					change_dir = true, -- cd into the mount on connect
				},
				on_disconnect = {
					clean_mount_folders = false,
				},
			},
			ui = {
				picker = "telescope",
				confirm = {
					connect = true,
					change_dir = false,
				},
			},
		})

		-- Load the telescope extension
		require("telescope").load_extension("remote-sshfs")

		-- Keymaps
		local api = require("remote-sshfs.api")
		local connections = require("remote-sshfs.connections")
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>rc", api.connect, { desc = "RemoteSSHFS: connect" })
		vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "RemoteSSHFS: disconnect" })
		vim.keymap.set("n", "<leader>re", api.edit, { desc = "RemoteSSHFS: edit SSH config" })

		-- Override <leader>ff and <leader>fg to switch between
		-- remote and local find/grep automatically
		vim.keymap.set("n", "<leader>ff", function()
			if connections.is_connected() then
				api.find_files()
			else
				builtin.find_files()
			end
		end, { desc = "Telescope: find files (local/remote)" })

		vim.keymap.set("n", "<leader>fg", function()
			if connections.is_connected() then
				api.live_grep()
			else
				builtin.live_grep()
			end
		end, { desc = "Telescope: live grep (local/remote)" })
	end,
}

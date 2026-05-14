return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    -- better layout for most use cases
                    layout_strategy = "horizontal",
                    layout_config = { preview_width = 0.55 },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            -- Load extensions
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")

            -- Keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>",      builtin.find_files,  { desc = "Telescope: find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,   { desc = "Telescope: live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Telescope: buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Telescope: help tags" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope: diagnostics" })
        end,
    },
}

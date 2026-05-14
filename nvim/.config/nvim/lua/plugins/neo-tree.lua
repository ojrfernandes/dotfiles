return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            -- Diagnostic icons (Neovim 0.10+ style)
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN]  = '',
                        [vim.diagnostic.severity.INFO]  = '',
                        [vim.diagnostic.severity.HINT]  = '󰌵',
                    },
                },
            })

            require("neo-tree").setup({
                close_if_last_window = true,   -- close nvim if neo-tree is the last window
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    follow_current_file = {
                        enabled = true,        -- highlight current file in the tree
                    },
                    use_libuv_file_watcher = true, -- auto-refresh on external file changes
                    filtered_items = {
                        hide_dotfiles = false, -- show dotfiles (useful for .env, .gitignore, etc.)
                        hide_gitignored = true,
                    },
                },
                window = {
                    width = 35,
                },
            })

            -- Toggle neo-tree (much more practical than just reveal)
            vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>", { desc = "Neo-tree: toggle" })
            -- Reveal current file in the tree
            vim.keymap.set("n", "<leader>nf", "<Cmd>Neotree reveal<CR>", { desc = "Neo-tree: reveal current file" })
        end,
    },
}

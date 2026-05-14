return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- Optional: only needed to override install_dir
            -- require('nvim-treesitter').setup {}

            -- Install parsers for your target languages
            require('nvim-treesitter').install({
                'lua', 'python', 'c', 'cpp', 'fortran', 'rust'
            })

            -- Enable treesitter highlighting for each filetype via autocommand
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'lua', 'python', 'c', 'cpp', 'fortran', 'rust' },
                callback = function() vim.treesitter.start() end,
            })
        end,
    }
}

-- Indentation
vim.opt.expandtab = true -- spaces instead of tabs
vim.opt.tabstop = 4 -- visual width of a tab character
vim.opt.softtabstop = 4 -- spaces inserted when pressing Tab
vim.opt.shiftwidth = 4 -- spaces used for auto-indent

-- Line numbers
vim.opt.number = true -- absolute line number on current line
vim.opt.relativenumber = true -- relative numbers on all other lines

-- Search
vim.opt.ignorecase = true -- case-insensitive search...
vim.opt.smartcase = true -- ...unless you type a capital letter

-- Appearance
vim.opt.termguicolors = true -- enables full 24-bit color (needed by catppuccin)
vim.opt.signcolumn = "yes" -- always show sign column (prevents layout shifting with LSP)
vim.opt.cursorline = true -- highlight the current line

-- Behaviour
vim.opt.splitright = true -- vertical splits open to the right
vim.opt.splitbelow = true -- horizontal splits open below
vim.opt.scrolloff = 8 -- keep 8 lines visible above/below cursor
vim.opt.updatetime = 250 -- faster UI updates (helps LSP diagnostics feel snappy)
vim.opt.wrap = false -- disable line wrapping

-- Window navigation (works with neo-tree and splits)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window: move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window: move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window: move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window: move right" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Window: increase height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Window: decrease height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Window: decrease width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Window: increase width" })

-- Save with Ctrl+S
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Cmd>w<CR>", { desc = "Save file" })

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- use system clipboard

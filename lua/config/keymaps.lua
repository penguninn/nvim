local vimkey = vim.keymap
local opts = { noremap = true, silent = true }

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remove search hightlights
vimkey.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- split window
vimkey.set("n", "<leader>wv", ":vsplit<cr>")
vimkey.set("n", "<leader>wh", ":split<cr>")

-- neo-tree
vimkey.set("n", "<leader>e", ":Neotree toggle<cr>", opts)
vimkey.set("n", "<C-h>", "<c-w>h", opts)
vimkey.set("n", "<C-l>", "<c-w>l", opts)
vimkey.set("n", "<C-j>", "<c-w>j", opts)
vimkey.set("n", "<C-k>", "<c-w>k", opts)

-- Telescope
vimkey.set("n", "<leader>fs", ":Telescope find_files<cr>")
vimkey.set("n", "<leader>fp", ":Telescope git_files<cr>")
vimkey.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vimkey.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- bufferline
vimkey.set("n", "<leader>n", ":bn<cr>")
vimkey.set("n", "<leader>p", ":bp<cr>")
vimkey.set("n", "<leader>x", ":bd<cr>")

-- lsp-config
vimkey.set("n", "K", vim.lsp.buf.hover)
vimkey.set("n", "gd", vim.lsp.buf.definition)
vimkey.set("n", "gD", vim.lsp.buf.declaration)
vimkey.set("n", "gr", vim.lsp.buf.references)
vimkey.set("n", "gi", vim.lsp.buf.implementation)
vimkey.set("n", "<leader>ca", vim.lsp.buf.code_action)
vimkey.set("n", "<leader>gf", vim.lsp.buf.format)
vimkey.set("n", "[d", vim.diagnostic.goto_prev)
vimkey.set("n", "]d", vim.diagnostic.goto_prev)

-- resize buffer
vimkey.set("n", "<leader>w", "<Nop>", opts)
vimkey.set("n", "<leader>w+", ":vertical resize +5<cr>", opts)
vimkey.set("n", "<leader>w-", ":vertical resize -5<cr>", opts)
vimkey.set("n", "<leader>h+", ":resize +5<cr>", opts)
vimkey.set("n", "<leader>h-", ":resize -5<cr>", opts)

-- utils
vimkey.set("n", "<C-d>", "yyp")
vimkey.set("n", "<C-a>", "gg<S-v>G")
vimkey.set("n", "<C-;>", vim.diagnostic.open_float)






local vimkey = vim.keymap
local opts = { noremap = true, silent = true }

-- neo-tree
vimkey.set("n", "<leader>e", ":Neotree toggle<cr>")
vimkey.set("n", "<c-h>", "<c-w>h")
vimkey.set("n", "<c-l>", "<c-w>l")
vimkey.set("n", "<c-j>", "<c-w>j")
vimkey.set("n", "<c-k>", "<c-w>k")

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
vimkey.set("n", "<leader>f",
	function()
		vim.lsp.buf.format({ async = true })
	end
	)
vimkey.set("n", "[d", vim.diagnostic.goto_prev)
vimkey.set("n", "]d", vim.diagnostic.goto_prev)
-- utils
vimkey.set("n", "<leader>d", "yyp")

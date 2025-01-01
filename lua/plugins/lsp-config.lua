return {
		{
				"williamboman/mason.nvim",
				config = function()
						require("mason").setup()
				end
		},
		{
				"williamboman/mason-lspconfig.nvim",
				dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
				config = function()
						require("mason-lspconfig").setup({
								ensure_installed = { "lua_ls", "ts_ls" },
								automatic_installation = true,
						})
				end
		},
		{
				"neovim/nvim-lspconfig",
				config = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({})
						lspconfig.ts_ls.setup({})
				end
		},
}


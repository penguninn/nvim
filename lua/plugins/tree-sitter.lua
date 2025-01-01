-- /lua/plugins/tree-sitter.lua

return {
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate",
		config = function()
				require("nvim-treesitter.configs").setup({
						ensure_installed = {
								"cmake",
								"cpp",
								"css",
								"gitignore",
								"go",
								"http",
								"html",
								"java",
								"python",
								"rust",
								"scss",
								"sql",
						},
						highlight = {
								enable = true,
								disable = {},
						},
						indent = {
								enable = true
						},
						auto_install = false,
				})	
		end,
}

return {
		"akinsho/bufferline.nvim", version = "*", 
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
				require('bufferline').setup {
						options = {
								-- numbers = "ordinal",
								diagnostics = "nvim_lsp",  
								modified_icon = "", 
								close_icon = "", 
								max_name_length = 18,
								tab_size = 20,
								show_buffer_icons = true,
								show_buffer_close_icons = true,
								show_close_icon = true,
								show_tab_indicators = true,
								color_icons = true,
						},
				}
		end,
}

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 21,
            open_mapping = [[<C-\>]],
            direction = "float",
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            persist_size = true,
            close_on_exit = true,
            shell = "powershell.exe",
        })
    end,
}

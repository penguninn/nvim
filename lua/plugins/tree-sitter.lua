-- /lua/plugins/tree-sitter.lua

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
                disable = {},
            },
            indent = {
                enable = true,
            },
            auto_install = true,
        })
    end,
}

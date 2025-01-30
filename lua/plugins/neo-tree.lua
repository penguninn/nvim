return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                config = function()
                    require("window-picker").setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            bo = {
                                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                                buftype = { "terminal", "quickfix" },
                            },
                        },
                    })
                end,
            },
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = false,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
                sort_case_insensitive = false,
                window = {
                    position = "left",
                    width = 25
                },
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        expander_collapsed = "",
                        expander_expanded = "",
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "󰜌",
                    },
                    modified = { symbol = "[+]" },
                    name = { trailing_slash = false },
                    git_status = {
                        symbols = {
                            added = "✚",
                            deleted = "✖",
                            renamed = "󰁕",
                            untracked = "",
                        },
                    },
                },
                filesystem = {
                    filtered_items = {
                        visible = true, -- Hiển thị các tệp bị lọc
                        hide_dotfiles = false, -- Hiển thị các tệp ẩn
                        hide_gitignored = false, -- Hiển thị các tệp bị gitignore
                        hide_hidden = false, -- Tùy chọn này chỉ có tác dụng trên Windows
                        hide_by_name = {}, -- Không ẩn bất kỳ thư mục nào theo tên
                        always_show = {}, -- Không có tệp nào sẽ luôn hiển thị
                    },
                },
            })
        end,
    },
}

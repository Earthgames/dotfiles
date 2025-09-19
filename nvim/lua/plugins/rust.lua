return {
    -- Rust everything
    {
        "mrcjkb/rustaceanvim",
        lazy = false,
    },
    -- Dioxus framework plugin
    {
        "mrxiaozhuox/dioxus.nvim",
        opts = {
            format = {
                split_line_attributes = true,
            },
        },
        ft = "rust",
    },
}

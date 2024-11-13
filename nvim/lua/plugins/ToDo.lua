return {
-- Discord
  "andweeb/presence.nvim",

-- Status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 1000,
    opts = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = ""},
      section_separators = { left = "", right = ""},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = { "filetype", "filename"},
        lualine_x = {"encoding"},
        lualine_y = {"progress", "location"},
        lualine_z = {
              function()
                return " " .. os.date("%R")
              end,
            },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {"nvim-tree"}
    },
  },

-- Fromatter
  "mhartington/formatter.nvim",

-- Todo highlighting
  "folke/todo-comments.nvim",

-- Haskell
  "mrcjkb/haskell-tools.nvim",

-- Comments
  "numToStr/Comment.nvim",

-- Rust analyzer
  "mrcjkb/rustaceanvim",

-- Completion framework:
  "hrsh7th/nvim-cmp",

-- LSP completion source:
  "hrsh7th/cmp-nvim-lsp",

-- Useful completion sources:
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/vim-vsnip"
}

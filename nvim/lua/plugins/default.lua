return {
-- FileTree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
-- Rainbow brackets
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
     lazy = false,
     priority = 999,
     config = function()
     require("rainbow-delimiters.setup").setup {
       highlight = {
         "DraculaFg",
         "DraculaPink",
         "DraculaCyan",
         "DraculaGreen",
         "DraculaPurple",
         "DraculaOrange",
         "DraculaRed"
       }
     }
   end
  },
-- Colourscheme
  {
    "dracula/vim",
     lazy = false,
     priority = 1000,
  },
}

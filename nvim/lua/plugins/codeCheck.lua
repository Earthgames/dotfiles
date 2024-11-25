return {
-- CodeTree
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = "all",
        highlight = { 
            enable = true,
            additional_vim_regex_highlighting=false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end
  },
-- Manage external editor tooling such as LSP servers, DAP servers, linters, and formatters 
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  -- "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
-- Debuger 
  { 
    "rcarriga/nvim-dap-ui", 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} 
  },

-- Linter
   -- {
   --   "mfussenegger/nvim-lint",
   --   opts = {
   --     events = { "BufWritePost", "BufReadPost", "InsertLeave" },
   --     linters_by_ft = {
   --       markdown = {"vale"},
   --       rust = {"clippy"},
   --       ["*"] = { "typos" }
   --     },
   --   }
   -- }
}

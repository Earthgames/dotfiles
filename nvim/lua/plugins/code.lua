return {
-- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
-- CodeTree
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "rust",
        "haskell",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    }
  },
-- Manage external editor tooling such as LSP servers, DAP servers, linters, and formatters 
  {
    "williamboman/mason.nvim",
    ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
    }
  },
  -- "williamboman/mason-lspconfig.nvim",
  -- "neovim/nvim-lspconfig",
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

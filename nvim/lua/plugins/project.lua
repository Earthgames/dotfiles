return {
  "ahmedkhalf/project.nvim",
  lazy=false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-tree.lua",
  },
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = { ".git", ">Rust"},
      exclude_dirs = {"~/.cargo/*"},
    })
    require("telescope").load_extension("projects")
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    })
  end,
  keys = {
    {
      "<c-f>",
      vim.schedule_wrap(
        function() require("telescope").extensions.projects.projects({}) 
      end),
    }
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
        },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Local files" },
      { "<leader>fn", "<cmd>Telescope lsp_dynamic_workspace_symbols default_text=#<cr>", desc = "Lsp symbols", ft = "rust",  },
      { "<leader>fn", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Lsp symbols"},
      { "<leader>fa", "<cmd>Telescope<cr>", desc = "Telescope" },
      { "<leader>d", "<cmd>Telescope lsp_definitions<cr>", desc = "Telescope" },
    },
    opts = {
      defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
          }
        }
      },
      pickers = {
        lsp_dynamic_workspace_symbols = {
          fname_width = 0,
          show_line = true,
          -- ignore_symbols = "struct",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      } 
    },
  }
}

return {
  {
    "coffebar/neovim-project",
    lazy = false,
    priority = 100,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    opts = {
      projects = { -- define project roots
        "~/Rust/*",
        "~/university/haskell/*",
        "~/git/*",
        "~/.dotfiles/*",
      },
      picker = {
        type = "telescope",
      },
      last_session_on_startup = true,
      -- Dashboard mode prevent session autoload on startup
      dashboard_mode = false,
      -- Timeout in milliseconds before trigger FileType autocmd after session load
      -- to make sure lsp servers are attached to the current buffer.
      -- Set to 0 to disable triggering FileType autocmd
      filetype_autocmd_timeout = 200,
      -- Keymap to delete project from history in Telescope picker
      forget_project_keys = {
        -- insert mode: Ctrl+d
        i = "<C-d>",
        -- normal mode: d
        n = "d"
      },
    },
    keys = {
      { "<leader>fp", "<cmd>NeovimProjectDiscover<cr>", desc = "Find projects", },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
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

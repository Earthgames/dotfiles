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
}

return {
  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "justinhj/battery.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
          "nvim-lua/plenary.nvim",
        },
        opts = {
          update_rate_seconds = 30, -- Number of seconds between checking battery status
          show_status_when_no_battery = false, -- Don't show any icon or text when no battery found (desktop for example)
          show_plugged_icon = true, -- If true show a cable icon alongside the battery icon when plugged in
          show_unplugged_icon = true, -- When true show a diconnected cable icon when not plugged in
          show_percent = true, -- Whether or not to show the percent charge remaining in digits
          -- vertical_icons = true,            -- When true icons are vertical, otherwise shows horizontal battery icon
        },
      },
    },
    lazy = false,
    priority = 1000,
    opts = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
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
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          "diagnostics",
          function()
            return require("battery").get_status_line()
          end,
        },
        lualine_c = { "filename", "filetype" },
        lualine_x = { "encoding" },
        lualine_y = { "progress", ":%l/%L☰ ℅:", "%c" },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
          function() -- trailing white space
            local space = vim.fn.search([[\s\+$]], "nwc")
            return space ~= 0 and "TW:" .. space or ""
          end,
          function()
            local space_pat = [[\v^ +]]
            local tab_pat = [[\v^\t+]]
            local space_indent = vim.fn.search(space_pat, "nwc")
            local tab_indent = vim.fn.search(tab_pat, "nwc")
            local mixed = (space_indent > 0 and tab_indent > 0)
            local mixed_same_line
            if not mixed then
              mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
              mixed = mixed_same_line > 0
            end
            if not mixed then
              return ""
            end
            if mixed_same_line ~= nil and mixed_same_line > 0 then
              return "MI:" .. mixed_same_line
            end
            local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
            local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
            if space_indent_cnt > tab_indent_cnt then
              return "MI:" .. tab_indent
            else
              return "MI:" .. space_indent
            end
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "nvim-tree" },
    },
  },
}

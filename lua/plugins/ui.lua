-- ============================================================================
-- UI - Tema y barra de estado
-- ============================================================================

return {
  -- Tema Moonlight
  {
    "shaunsingh/moonlight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_variables = false
      vim.g.moonlight_contrast = true
      vim.g.moonlight_borders = false
      vim.g.moonlight_disable_background = false
      vim.cmd("colorscheme moonlight")
    end,
  },

  -- Barra de estado
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "moonlight",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              function()
                local status = vim.fn["codeium#GetStatusString"]()
                return "⚡" .. status
              end,
              color = { fg = "#00ff00" },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Iconos
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}

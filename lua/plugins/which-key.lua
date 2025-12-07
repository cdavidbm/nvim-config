-- ============================================================================
-- WHICH-KEY - Muestra sugerencias de keymaps
-- ============================================================================

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")

      wk.setup({
        preset = "modern",
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
        },
      })

      -- Agregar descripciones de grupos usando add
      wk.add({
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>t", group = "Toggle / Terminal" },
        { "<leader>c", group = "Codeium" },
        { "<leader>w", group = "Workspace" },
        { "<leader>u", group = "UV (Python)" },
        { "<leader>s", group = "SuperCollider" },
      })
    end,
  },
}

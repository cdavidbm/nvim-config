-- ============================================================================
-- AVANTE - Chat con IA integrado en Neovim
-- ============================================================================

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      -- Soporte para imágenes
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
          },
        },
      },
      -- Render de markdown
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      -- Proveedor de IA (claude-code usa OAuth, ya autenticado)
      provider = "claude-code",
    },
  },

  -- Dressing - UI mejorada para inputs
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {},
  },
}

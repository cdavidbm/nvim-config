-- ============================================================================
-- COMMENT - Comentar/descomentar código fácilmente
-- ============================================================================

return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        -- Prefijo para comentarios en modo normal
        padding = true,
        sticky = true,
        ignore = nil,

        -- Keymaps
        toggler = {
          line = "gcc",  -- Comentar línea actual
          block = "gbc", -- Comentar bloque
        },
        opleader = {
          line = "gc",   -- Comentar líneas en modo normal/visual
          block = "gb",  -- Comentar bloque en modo normal/visual
        },
        extra = {
          above = "gcO", -- Comentar línea arriba
          below = "gco", -- Comentar línea abajo
          eol = "gcA",   -- Comentar al final de línea
        },

        -- Integración con treesitter para comentarios contextuales
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  -- Context commentstring - Comentarios inteligentes según contexto
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}

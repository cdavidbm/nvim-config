-- ============================================================================
-- CODEIUM - Asistente de IA (autocompletado inteligente)
-- ============================================================================

return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Desactivar bindings por defecto
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_manual = false
      vim.g.codeium_idle_delay = 75

      local keymap = vim.keymap.set

      -- Aceptar sugerencias
      keymap("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar sugerencia" })

      keymap("i", "<C-Right>", function()
        return vim.fn["codeium#AcceptNextWord"]()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar siguiente palabra" })

      keymap("i", "<C-l>", function()
        return vim.fn["codeium#AcceptNextLine"]()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar línea" })

      -- Navegar sugerencias
      keymap("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true, desc = "Codeium: Siguiente sugerencia" })

      keymap("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true, desc = "Codeium: Sugerencia anterior" })

      -- Cancelar
      keymap("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true, desc = "Codeium: Cancelar sugerencia" })

      -- Comandos en modo normal
      keymap("n", "<leader>ce", function()
        vim.fn["codeium#Enable"]()
        print("Codeium habilitado")
      end, { desc = "Codeium: Habilitar" })

      keymap("n", "<leader>cd", function()
        vim.fn["codeium#Disable"]()
        print("Codeium deshabilitado")
      end, { desc = "Codeium: Deshabilitar" })

      keymap("n", "<leader>cc", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, desc = "Codeium: Abrir chat en navegador" })
    end,
  },
}

-- ============================================================================
-- SURROUND - Manipular comillas, paréntesis, tags fácilmente
-- ============================================================================

return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuración por defecto funciona perfecto
        -- Uso básico:
        -- ys{motion}{char} - Agregar surround
        -- ds{char}         - Eliminar surround
        -- cs{target}{replacement} - Cambiar surround
        -- Ejemplos:
        -- ysiw"  - Rodea palabra con comillas dobles
        -- ds"    - Elimina comillas dobles
        -- cs"'   - Cambia comillas dobles por simples
        -- yss)   - Rodea línea con paréntesis
        -- ySS{   - Rodea línea con llaves en bloque
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end,
  },
}

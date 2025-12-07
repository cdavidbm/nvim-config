-- ============================================================================
-- COLORIZER - Ver colores inline (#ff0000 se muestra en rojo)
-- ============================================================================

return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Habilitar en todos los archivos
          css = { rgb_fn = true, hsl_fn = true }, -- rgb(), hsl()
          html = { names = true }, -- Nombres de colores como "red"
          javascript = { RGB = true },
          typescript = { RGB = true },
          lua = { names = false },
        },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes como Blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          mode = "background", -- Set the display mode: 'foreground', 'background', 'virtualtext'
          tailwind = true, -- Enable tailwind colors
          sass = { enable = true, parsers = { "css" } },
          virtualtext = "■",
          always_update = false,
        },
        buftypes = {},
      })

      -- Comandos para toggle
      vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<CR>", { desc = "Toggle colorizer" })
    end,
  },
}

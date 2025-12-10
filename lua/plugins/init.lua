-- ============================================================================
-- LAZY.NVIM - Gestor de plugins
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- CARGAR PLUGINS
-- ============================================================================
require("lazy").setup({
  -- Importar configuraciones modulares
  { import = "plugins.alpha" },
  { import = "plugins.telescope" },
  { import = "plugins.which-key" },
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.comment" },
  { import = "plugins.toggleterm" },
  { import = "plugins.gitsigns" },
  { import = "plugins.surround" },
  { import = "plugins.colorizer" },
  { import = "plugins.lsp" },
  { import = "plugins.cmp" },
  { import = "plugins.treesitter" },
  { import = "plugins.codeium" },
  { import = "plugins.avante" },
  { import = "plugins.scnvim" },
  { import = "plugins.smear_cursor" },
  { import = "plugins.neoscroll" },
  { import = "plugins.lilypond" },
}, {
  -- Opciones de lazy.nvim
  rocks = {
    enabled = false,
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
    },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

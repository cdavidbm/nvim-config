-- ============================================================================
-- OPCIONES GENERALES DE VIM
-- ============================================================================

local opt = vim.opt

-- Apariencia
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.fillchars = { eob = " " }

-- Indentación
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Búsqueda
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Archivos y respaldo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Rendimiento
opt.updatetime = 100
opt.timeoutlen = 300

-- Sistema
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect"
opt.splitbelow = true
opt.splitright = true

-- Desactivar netrw (usamos nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- DIAGNÓSTICOS
-- ============================================================================
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Highlights personalizados para marks
vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#ff9e64", bold = true })
vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "#7aa2f7" })

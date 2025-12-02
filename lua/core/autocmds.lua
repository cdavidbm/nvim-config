-- ============================================================================
-- AUTOCOMANDOS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- NUMERACIÓN AUTOMÁTICA (relativa en Normal, absoluta en Insert)
-- ============================================================================
local numbertoggle = augroup("NumberToggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
  desc = "Activar números relativos en modo Normal",
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
  desc = "Desactivar números relativos en modo Insert",
})

-- ============================================================================
-- FORMATO AUTOMÁTICO
-- ============================================================================
autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Formatear Python al guardar",
})

-- ============================================================================
-- HIGHLIGHT AL COPIAR
-- ============================================================================
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  desc = "Highlight al copiar texto",
})

-- ============================================================================
-- CONFIGURACIÓN POR TIPO DE ARCHIVO
-- ============================================================================
autocmd("FileType", {
  pattern = { "javascript", "typescript", "html", "css", "json", "yaml", "lua", "markdown", "txt"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
  desc = "2 espacios para web/config files + wrap",
})

-- ============================================================================
-- MENSAJE DE BIENVENIDA
-- ============================================================================
autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      print("Neovim listo! | uv: <leader>u | Árbol: Ctrl+n | Codeium: Ctrl+g")
    end, 100)
  end,
  desc = "Mensaje de ayuda al iniciar",
})

-- ============================================================================
-- CERRAR CIERTOS BUFFERS CON 'q'
-- ============================================================================
autocmd("FileType", {
  pattern = { "help", "qf", "lspinfo", "man", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Cerrar ventanas de ayuda con q",
})

-- ============================================================================
-- RESTAURAR POSICIÓN DEL CURSOR
-- ============================================================================
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restaurar posición del cursor al abrir archivo",
})

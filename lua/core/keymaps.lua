-- ============================================================================
-- KEYMAPS GLOBALES
-- ============================================================================
-- Nota: Los keymaps específicos de plugins están en sus respectivos archivos

local keymap = vim.keymap.set

-- Diagnósticos
keymap('n', '<space>e', vim.diagnostic.open_float, { desc = "Mostrar diagnóstico flotante" })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnóstico siguiente" })
keymap('n', '<space>q', vim.diagnostic.setloclist, { desc = "Lista de diagnósticos" })

-- Navegación entre ventanas (también está en vim-tmux-navigator)
-- keymap('n', '<C-h>', '<C-w>h', { desc = "Ventana izquierda" })
-- keymap('n', '<C-j>', '<C-w>j', { desc = "Ventana abajo" })
-- keymap('n', '<C-k>', '<C-w>k', { desc = "Ventana arriba" })
-- keymap('n', '<C-l>', '<C-w>l', { desc = "Ventana derecha" })

-- Mover líneas en modo visual
keymap('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Mover línea abajo" })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Mover línea arriba" })

-- Mantener cursor centrado
keymap('n', '<C-d>', '<C-d>zz', { desc = "Scroll down centrado" })
keymap('n', '<C-u>', '<C-u>zz', { desc = "Scroll up centrado" })
keymap('n', 'n', 'nzzzv', { desc = "Siguiente resultado centrado" })
keymap('n', 'N', 'Nzzzv', { desc = "Resultado anterior centrado" })

-- Mejor indentación en modo visual
keymap('v', '<', '<gv', { desc = "Indentar izquierda" })
keymap('v', '>', '>gv', { desc = "Indentar derecha" })

-- Buffer navigation
keymap('n', '<S-h>', ':bprevious<CR>', { desc = "Buffer anterior" })
keymap('n', '<S-l>', ':bnext<CR>', { desc = "Buffer siguiente" })

-- Guardar rápido
keymap('n', '<leader>w', ':w<CR>', { desc = "Guardar archivo" })
keymap('n', '<leader>q', ':q<CR>', { desc = "Cerrar ventana" })

-- Limpiar búsqueda
keymap('n', '<Esc>', ':noh<CR>', { desc = "Limpiar highlight búsqueda" })

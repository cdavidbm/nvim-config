-- ============================================================================
-- linkear tmux.conf
-- ln -s ~/.config/nvim/tmux.conf ~/.tmux.conf
-- tmux source-file ~/.tmux.conf
-- ============================================================================


-- Silenciar advertencias de deprecación
vim.g.deprecation_warnings = false
vim.deprecate = function() return function() end end

-- Leader keys (debe ir antes de cargar plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cargar módulos
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("plugins")

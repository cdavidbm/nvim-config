-- ~/.config/nvim/init.lua

-- ============================================================================
-- SILENCIAR ADVERTENCIAS DE DEPRECACIÓN
-- ============================================================================
vim.g.deprecation_warnings = false
vim.deprecate = function() return function() end end

-- ============================================================================
-- CONFIGURACIÓN DE LAZY.NVIM (Gestor de plugins)
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
-- PLUGINS
-- ============================================================================
require("lazy").setup({

  -- tema Moonlight
  {
    "shaunsingh/moonlight.nvim",
    lazy = false,    -- Cargar inmediatamente
    priority = 1000, -- Cargar antes que otros plugins
    config = function()
      -- Configuración opcional del tema
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_variables = false
      vim.g.moonlight_contrast = true
      vim.g.moonlight_borders = false
      vim.g.moonlight_disable_background = false

      -- Activar el tema
      vim.cmd("colorscheme moonlight")
    end,
  },

  -- CODEIUM - Asistente de IA GRATIS
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Desactivar mapeos por defecto de Codeium
      vim.g.codeium_disable_bindings = 1

      -- Configuración de Codeium
      vim.g.codeium_manual = false -- Activar sugerencias automáticas
      vim.g.codeium_idle_delay = 75 -- Delay antes de mostrar sugerencias (ms)

      -- ATAJOS DE TECLADO PARA CODEIUM
      -- Aceptar sugerencia completa
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar sugerencia" })

      -- Aceptar palabra por palabra
      vim.keymap.set('i', '<C-Right>', function()
        return vim.fn['codeium#AcceptNextWord']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar siguiente palabra" })

      -- Aceptar línea por línea
      vim.keymap.set('i', '<C-l>', function()
        return vim.fn['codeium#AcceptNextLine']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar línea" })

      -- Siguiente sugerencia
      vim.keymap.set('i', '<M-]>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = "Codeium: Siguiente sugerencia" })

      -- Sugerencia anterior
      vim.keymap.set('i', '<M-[>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = "Codeium: Sugerencia anterior" })

      -- Limpiar/Cancelar sugerencia actual
      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = "Codeium: Cancelar sugerencia" })

      -- Activar/Desactivar Codeium manualmente
      vim.keymap.set('n', '<leader>ce', function()
        vim.fn['codeium#Enable']()
        print("Codeium habilitado")
      end, { desc = "Codeium: Habilitar" })

      vim.keymap.set('n', '<leader>cd', function()
        vim.fn['codeium#Disable']()
        print("Codeium deshabilitado")
      end, { desc = "Codeium: Deshabilitar" })

      -- Mostrar estado de Codeium
      vim.keymap.set('n', '<leader>cs', function()
        vim.fn['codeium#GetStatusString']()
      end, { desc = "Codeium: Mostrar estado" })

      -- Chat con Codeium (abre en navegador)
      vim.keymap.set('n', '<leader>cc', function()
        return vim.fn['codeium#Chat']()
      end, { expr = true, desc = "Codeium: Abrir chat" })
    end,
  },

  -- LSP (Language Server Protocol)
  {
    "neovim/nvim-lspconfig",
    tag = "v0.1.8", -- Usar una versión estable específica
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Auto-pairs (cierra automáticamente paréntesis, corchetes, etc.)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        disable_in_macro = false,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,
        enable_check_bracket_line = true,
        enable_bracket_in_quote = true,
        enable_abbr = false,
        break_undo = true,
        check_ts = true,
        map_cr = true,
        map_bs = true,
        map_c_h = false,
        map_c_w = false,
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          manual_position = true,
          highlight = 'Search',
          highlight_grey = 'Comment'
        },
      })
    end,
  },

  -- Treesitter (mejor resaltado de sintaxis) - opcional pero recomendado
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- OPCIONAL: Barra de estado para ver el estado de Codeium
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'moonlight',
        },
        sections = {
          lualine_x = {
            -- Mostrar estado de Codeium en la barra
            {
              function()
                local status = vim.fn['codeium#GetStatusString']()
                return '⚡' .. status
              end,
              color = { fg = '#00ff00' }
            },
            'encoding',
            'fileformat',
            'filetype'
          },
        }
      })
    end,
  },
})

-- ============================================================================
-- CONFIGURACIÓN DE MASON (Instalador de LSP)
-- ============================================================================
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "ruff" },
  automatic_installation = true,
})

-- ============================================================================
-- CONFIGURACIÓN DE AUTOCOMPLETADO (nvim-cmp)
-- ============================================================================
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Cargar snippets de VSCode
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- Navegación con Tab y Shift-Tab
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Iconos para diferentes tipos de completado
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      return vim_item
    end
  },
})

-- Integración de autopairs con cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- ============================================================================
-- CONFIGURACIÓN DE LSP
-- ============================================================================
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Función para configurar LSP sin advertencias
local function setup_lsp()
  local lspconfig = require('lspconfig')

  -- Configurar Pyright
  lspconfig.pyright.setup({
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic",
          autoImportCompletions = true,
        },
      },
    },
  })

  -- Configurar Ruff
  -- Intentar primero con 'ruff', si no existe usar 'ruff_lsp'
  local ruff_config = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Desabilitar hover para ruff (dejar que pyright lo maneje)
      if client.name == 'ruff' or client.name == 'ruff_lsp' then
        client.server_capabilities.hoverProvider = false
      end
    end,
  }

  -- Intentar configurar ruff o ruff_lsp
  local ok = pcall(function() lspconfig.ruff.setup(ruff_config) end)
  if not ok then
    pcall(function() lspconfig.ruff_lsp.setup(ruff_config) end)
  end
end

-- Configurar LSP después de que los plugins se carguen
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    setup_lsp()
  end,
})

-- ============================================================================
-- ATAJOS DE TECLADO PARA LSP
-- ============================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    -- Navegación
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- Workspace
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- Acciones
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Atajos para diagnósticos
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- ============================================================================
-- CONFIGURACIÓN GENERAL DE VIM
-- ============================================================================
-- Números de línea
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentación
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Búsqueda
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Apariencia
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Comportamiento
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- Portapapeles del sistema
vim.opt.clipboard = "unnamedplus"

-- Completado
vim.opt.completeopt = "menuone,noselect"

-- Split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Configurar leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Mejorar el rendimiento de renderizado
vim.opt.lazyredraw = false   -- No usar lazyredraw (puede causar problemas en WSL)
vim.opt.ttyfast = true       -- Terminal rápida
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10

-- Reducir el tiempo de actualización
vim.opt.updatetime = 100    -- Más rápido que 50

-- Deshabilitar algunas características que pueden causar problemas
vim.opt.cursorline = false  -- Desactivar línea del cursor (consume recursos)
vim.opt.cursorcolumn = false
vim.opt.synmaxcol = 240     -- Limitar el resaltado de sintaxis

-- Para WSL específicamente
if vim.fn.has('wsl') == 1 then
  vim.opt.lazyredraw = false
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- ============================================================================
-- AUTO-COMANDOS
-- ============================================================================
-- Formatear Python con Ruff al guardar (opcional, comenta si no quieres)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Resaltar yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Configurar indentación específica para algunos tipos de archivo
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "html", "css", "json", "yaml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- ============================================================================
-- CONFIGURACIÓN DE DIAGNÓSTICOS
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

-- Iconos para diagnósticos
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- MENSAJE DE AYUDA PARA CODEIUM
-- ============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      print("Codeium está listo! Usa :Codeium Auth para autenticarte (primera vez)")
    end, 100)
  end,
})

-- linkear tmux.conf
-- ln -s ~/.config/nvim/tmux.conf ~/.tmux.conf
-- tmux source-file ~/.tmux.conf

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
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_variables = false
      vim.g.moonlight_contrast = true
      vim.g.moonlight_borders = false
      vim.g.moonlight_disable_background = false
      vim.cmd("colorscheme moonlight")
    end,
  },


    {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navegar izquierda" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navegar abajo" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navegar arriba" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navegar derecha" },
  },
},

  -- CODEIUM - Asistente de IA GRATIS
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_manual = false
      vim.g.codeium_idle_delay = 75

      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar sugerencia" })

      vim.keymap.set('i', '<C-Right>', function()
        return vim.fn['codeium#AcceptNextWord']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar siguiente palabra" })

      vim.keymap.set('i', '<C-l>', function()
        return vim.fn['codeium#AcceptNextLine']()
      end, { expr = true, silent = true, desc = "Codeium: Aceptar línea" })

      vim.keymap.set('i', '<M-]>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = "Codeium: Siguiente sugerencia" })

      vim.keymap.set('i', '<M-[>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = "Codeium: Sugerencia anterior" })

      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = "Codeium: Cancelar sugerencia" })

      vim.keymap.set('n', '<leader>ce', function()
        vim.fn['codeium#Enable']()
        print("Codeium habilitado")
      end, { desc = "Codeium: Habilitar" })

      vim.keymap.set('n', '<leader>cd', function()
        vim.fn['codeium#Disable']()
        print("Codeium deshabilitado")
      end, { desc = "Codeium: Deshabilitar" })

      vim.keymap.set('n', '<leader>cc', function()
        return vim.fn['codeium#Chat']()
      end, { expr = true, desc = "Codeium: Abrir chat en navegador" })
    end,
  },

  -- Plugin de SuperCollider
  {
    "davidgranstrom/scnvim",
    ft = "supercollider",
    config = function()
      local scnvim = require("scnvim")
      local map = scnvim.map
      scnvim.setup({
        keymaps = {
          ["<C-e>"] = map("editor.send_block", {"n", "i"}),
          ["<C-l>"] = map("editor.send_line", {"n", "i"}),
          ["<C-k>"] = map("postwin.toggle", "n"),
          ["<C-.>"] = map("sclang.hard_stop", {"n", "i"}),
        },
        postwin = {
          float = {
            enabled = true,
                -- width = 60,
                -- height = 40,
                -- row = 2,    -- distancia desde arriba
                -- col = 10,   -- distancia desde la izquierda
          },
        },
      })
    end,
  },

  -- Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
          custom = { ".git", "node_modules", ".cache", "__pycache__" },
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,
            },
          },
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
      vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'Focus file tree' })
      vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })
    end,
  },

  -- Mason (Instalador de LSP)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- LSPConfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- Mason-LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = { "pyright", "emmet_ls" },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

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

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      })

      if vim.fn.executable('ruff') == 1 then
        lspconfig.ruff.setup({
          capabilities = capabilities,
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        })
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    end,
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

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

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- Auto-pairs
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

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc", "javascript", "typescript", "html", "css" },
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

  -- Barra de estado
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

  -- Emmet para HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "php" },
    config = function()
      vim.g.user_emmet_leader_key = '<C-y>'
    end,
  },

  {
  "chentoast/marks.nvim",
  config = function()
    require("marks").setup({
      default_mappings = true,
      signs = true,
      mappings = {}
    })
  end,
},

{
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "claude-code",
  },
},

}, {
  -- OPCIONES DE LAZY.NVIM (segundo argumento)
  rocks = {
    enabled = false,
  },
})

-- ============================================================================
-- CONFIGURACIÓN GENERAL DE VIM
-- ============================================================================
vim.opt.fillchars = { eob = " " } -- ocultar el simbolo ~

-- Colores
vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#ff9e64", bold = true })      -- marcas minúsculas
vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "#7aa2f7" })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- NUMERACIÓN AUTOMÁTICA (relativa en Normal, absoluta en Insert)
-- ============================================================================
local numbertoggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
  desc = "Activar números relativos en modo Normal",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
  desc = "Desactivar números relativos en modo Insert",
})

-- ============================================================================
-- AUTO-COMANDOS
-- ============================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ============================================================================
-- MENSAJE DE AYUDA
-- ============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      print("Neovim listo! | Codeium: :Codeium Auth | Árbol: Ctrl+n | Nums: relativos↔absolutos auto")
    end, 100)
  end,
})

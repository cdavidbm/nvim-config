-- ============================================================================
-- LSP - Language Server Protocol
-- ============================================================================

return {
  -- Mason - Instalador de LSP
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-LSPConfig - Puente entre Mason y lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = { "emmet_ls", "ruff" },
        automatic_installation = true,
      })

      -- ========================================
      -- CONFIGURACIÓN DE SERVIDORES LSP
      -- ========================================

      -- EMMET - Autocompletado HTML/CSS
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      })

      -- RUFF - Linting y formato para Python
      if vim.fn.executable("ruff") == 1 then
        lspconfig.ruff.setup({
          capabilities = capabilities,
        })
      end

      -- ========================================
      -- KEYMAPS LSP (se activan al conectar LSP)
      -- ========================================
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          local keymap = vim.keymap.set

          -- Navegación
          keymap("n", "gD", vim.lsp.buf.declaration, opts)
          keymap("n", "gd", vim.lsp.buf.definition, opts)
          keymap("n", "gi", vim.lsp.buf.implementation, opts)
          keymap("n", "gr", vim.lsp.buf.references, opts)
          keymap("n", "K", vim.lsp.buf.hover, opts)
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)

          -- Workspace
          keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
          keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          keymap("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)

          -- Refactoring
          keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
          keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
          keymap({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

          -- Formato
          keymap("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },

  -- LSPConfig base
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },
}

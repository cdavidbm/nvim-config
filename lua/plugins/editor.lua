-- ============================================================================
-- EDITOR - Herramientas de edición
-- ============================================================================

return {
  -- Navegación tmux
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

  -- Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle árbol de archivos" },
      { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Foco en árbol" },
      { "<leader>tf", "<cmd>NvimTreeFindFile<CR>", desc = "Encontrar archivo en árbol" },
    },
    config = function()
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
            window_picker = { enable = false },
          },
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
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
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          manual_position = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })
    end,
  },

  -- Marks visuales
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    config = function()
      require("marks").setup({
        default_mappings = true,
        signs = true,
        mappings = {},
      })
    end,
  },

  -- UV.NVIM - Integración con uv para Python
  {
    "benomahony/uv.nvim",
    ft = "python",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("uv").setup({
        auto_activate_venv = true,
        notify_activate_venv = true,
        auto_commands = true,
        keymaps = {
          prefix = "<leader>u",
          commands = true,
          run_file = true,
          run_selection = true,
          run_function = true,
        },
      })
    end,
  },

  -- Emmet para HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "php" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
}

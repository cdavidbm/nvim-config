-- ============================================================================
-- TELESCOPE - Fuzzy Finder
-- ============================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      -- Buscar archivos
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar archivos" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Buscar todos los archivos" },
      
      -- Buscar texto
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Buscar texto (grep)" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Buscar palabra bajo cursor" },
      
      -- Archivos recientes y buffers
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Archivos recientes" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buscar buffers" },
      
      -- Utilidades
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Buscar ayuda" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Buscar comandos" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Buscar keymaps" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Buscar marks" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Buscar opciones vim" },
      
      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
      
      -- Buscar en archivo actual
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buscar en buffer actual" },
      
      -- Tema (cambiar colorscheme)
      { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Cambiar tema" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Apariencia
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          
          -- Comportamiento
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.cache",
            "__pycache__",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip",
          },
          
          -- Keymaps dentro de Telescope
          mappings = {
            i = {
              -- Navegación
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              
              -- Cerrar
              ["<C-c>"] = actions.close,
              ["<Esc>"] = actions.close,
              
              -- Preview
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              
              -- Selección
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              
              -- Historial
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
            },
            n = {
              ["<C-c>"] = actions.close,
              ["q"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
          
          -- Estilo
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
        },
        
        -- Configuración específica para comandos
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          oldfiles = {
            theme = "dropdown",
            previewer = false,
          },
          git_branches = {
            theme = "dropdown",
            previewer = false,
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        
        -- Extensiones
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Cargar extensión fzf
      telescope.load_extension("fzf")
    end,
  },
}

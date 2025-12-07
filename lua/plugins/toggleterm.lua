-- ============================================================================
-- TOGGLETERM - Terminal flotante integrada
-- ============================================================================

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", desc = "Toggle terminal" },
      { "<leader>tf", desc = "Terminal flotante" },
      { "<leader>th", desc = "Terminal horizontal" },
      { "<leader>tv", desc = "Terminal vertical" },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
          winblend = 3,
        },
        winbar = {
          enabled = false,
        },
      })

      -- Función helper para crear terminales
      local Terminal = require("toggleterm.terminal").Terminal

      -- Terminal flotante
      local float_term = Terminal:new({
        direction = "float",
        hidden = true,
      })

      function _FLOAT_TERM_TOGGLE()
        float_term:toggle()
      end

      -- Terminal horizontal
      local horizontal_term = Terminal:new({
        direction = "horizontal",
        hidden = true,
      })

      function _HORIZONTAL_TERM_TOGGLE()
        horizontal_term:toggle()
      end

      -- Terminal vertical
      local vertical_term = Terminal:new({
        direction = "vertical",
        hidden = true,
      })

      function _VERTICAL_TERM_TOGGLE()
        vertical_term:toggle()
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>tf", "<cmd>lua _FLOAT_TERM_TOGGLE()<CR>", { desc = "Terminal flotante" })
      vim.keymap.set("n", "<leader>th", "<cmd>lua _HORIZONTAL_TERM_TOGGLE()<CR>", { desc = "Terminal horizontal" })
      vim.keymap.set("n", "<leader>tv", "<cmd>lua _VERTICAL_TERM_TOGGLE()<CR>", { desc = "Terminal vertical" })

      -- Keymaps en modo terminal
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}

-- ============================================================================
-- SCNVIM - SuperCollider para Neovim
-- ============================================================================

return {
  {
    "davidgranstrom/scnvim",
    ft = "supercollider",
    config = function()
      local scnvim = require("scnvim")
      local map = scnvim.map
      local map_expr = scnvim.map_expr

      scnvim.setup({
        keymaps = {
          ["<C-e>"] = map("editor.send_block", { "n", "i" }),
          ["<C-o>"] = map("editor.send_line", { "n", "i" }),
          ["<C-p>"] = map("postwin.toggle", "n"),
          ["<C-r>"] = map("sclang.hard_stop", { "n", "i" }),
          ['<leader>sc'] = map('sclang.start'),
          ['<F4>'] = map('sclang.stop'),
          ['<F3>'] = map_expr('s.boot'),
          ['<F2>'] = map_expr('s.meter'),
        },
        postwin = {
          float = {
            enabled = true,
          },
        },
        editor = {
          highlight = {
            color = "IncSearch",
          },
        },
      })
    end,
  },
}

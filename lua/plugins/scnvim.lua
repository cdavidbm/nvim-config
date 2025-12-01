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

      scnvim.setup({
        keymaps = {
          ["<C-e>"] = map("editor.send_block", { "n", "i" }),
          ["<C-l>"] = map("editor.send_line", { "n", "i" }),
          ["<C-k>"] = map("postwin.toggle", "n"),
          ["<C-.>"] = map("sclang.hard_stop", { "n", "i" }),
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

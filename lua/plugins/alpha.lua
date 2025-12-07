-- ============================================================================
-- ALPHA - Pantalla de inicio personalizada
-- ============================================================================

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Arte ASCII de Virtual Adept
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[    ██╗   ██╗██╗██████╗ ████████╗██╗   ██╗ █████╗ ██╗               ]],
      [[    ██║   ██║██║██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██║               ]],
      [[    ██║   ██║██║██████╔╝   ██║   ██║   ██║███████║██║               ]],
      [[    ╚██╗ ██╔╝██║██╔══██╗   ██║   ██║   ██║██╔══██║██║               ]],
      [[     ╚████╔╝ ██║██║  ██║   ██║   ╚██████╔╝██║  ██║███████╗          ]],
      [[      ╚═══╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝          ]],
      [[                                                                       ]],
      [[         █████╗ ██████╗ ███████╗██████╗ ████████╗                    ]],
      [[        ██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝                    ]],
      [[        ███████║██║  ██║█████╗  ██████╔╝   ██║                       ]],
      [[        ██╔══██║██║  ██║██╔══╝  ██╔═══╝    ██║                       ]],
      [[        ██║  ██║██████╔╝███████╗██║        ██║                       ]],
      [[        ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝        ╚═╝                       ]],
      [[                                                                       ]],
      [[              [ Reality is just a consensual hallucination ]          ]],
      [[                                                                       ]],
    }

    -- Botones de acceso rápido
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Buscar archivo", ":Telescope find_files <CR>"),
      dashboard.button("n", "  Nuevo archivo", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recientes", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Buscar texto", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuración", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("q", "  Salir", ":qa<CR>"),
    }

    -- Footer con información
    local function footer()
      local datetime = os.date(" %d/%m/%Y   %H:%M:%S")
      local version = vim.version()
      local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch
      return datetime .. "   " .. nvim_version_info
    end

    dashboard.section.footer.val = footer()

    -- Colores personalizados
    dashboard.section.header.opts.hl = "Type"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    -- Configurar alpha
    alpha.setup(dashboard.opts)

    -- Deshabilitar statusline y tabline en alpha
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}

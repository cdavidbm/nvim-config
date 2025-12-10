-- ============================================================================
-- LILYPOND - Soporte completo para notación musical
-- ============================================================================

return {
  -- ============================================================================
  -- Plugin principal: nvim-lilypond-suite
  -- ============================================================================
  {
    'martineausimon/nvim-lilypond-suite',
    ft = { 'lilypond' },
    config = function()
      require('nvls').setup({
        lilypond = {
          -- Opciones del compilador LilyPond
          options = {
            output = "pdf",  -- Formato de salida: pdf, svg, png
            backend = nil,  -- Backend de renderizado (nil = usar predeterminado)
            preview = true,  -- Vista previa automática
            main_file = nil,  -- nil = usar archivo actual (no buscar main.ly)
            main_folder = "%:p:h",  -- Carpeta del archivo actual
            diagnostics = true,  -- Mostrar errores en quickfix
          },
          -- Mapeos de teclas personalizados
          mappings = {
            compile = "<leader>lc",  -- Compilar archivo
            open_pdf = "<leader>lo",  -- Abrir PDF
            switch_buffers = "<leader>ls",  -- Cambiar entre archivos
            player = "<leader>lp",  -- Abrir reproductor MIDI/MP3
            hyphenation = "<leader>lh",  -- Función de silabeo
            hyphenation_change_lang = "<leader>lm",  -- Cambiar idioma
            insert_version = "<leader>lv",  -- Insertar versión de LilyPond
          },
        },
        latex = {
          -- Soporte para LilyPond embebido en LaTeX
          enabled = true,
          options = {
            output = "pdf",
          },
          mappings = {
            compile = "<leader>lc",
            open_pdf = "<leader>lo",
            lilypond_syntax = "<leader>ll",
          },
        },
        texinfo = {
          -- Soporte para LilyPond embebido en Texinfo
          enabled = false,
        },
        player = {
          -- Configuración del reproductor
          enabled = true,
          mappings = {
            quit = "q",
            play_pause = "p",
            loop = "<A-l>",
            backward = "h",
            small_backward = "<S-h>",
            forward = "l",
            small_forward = "<S-l>",
            decrease_speed = "j",
            increase_speed = "k",
            halve_speed = "<S-j>",
            double_speed = "<S-k>",
          },
          opts = {
            row = "2%",
            col = "99%",
            width = "37",
            height = "1",
            border = "rounded",
          },
        },
      })

      -- Auto-comandos adicionales para LilyPond
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lilypond",
        callback = function()
          -- Configuraciones específicas para archivos LilyPond
          vim.opt_local.commentstring = "% %s"
          vim.opt_local.expandtab = true
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
          
          -- Mensajes informativos
          vim.notify("LilyPond suite cargado - Usa <leader>l para comandos", vim.log.levels.INFO)
        end,
      })
    end,
  },

  -- ============================================================================
  -- Entrada MIDI: Escribir notación usando teclado MIDI (OPCIONAL)
  -- ============================================================================
  {
    'niveK77pur/midi-input.nvim',
    ft = { 'lilypond' },
    cmd = { 'MidiInputStart', 'MidiInputStop', 'MidiInputToggle' },
    enabled = false,  -- Deshabilitado por defecto - cambiar a true si tienes teclado MIDI
    config = function()
      local ok, midi_input = pcall(require, 'midi-input')
      if not ok then
        vim.notify("midi-input.nvim no está disponible", vim.log.levels.WARN)
        return
      end

      midi_input.setup({
        -- Configuración del input MIDI
        auto_start = false,  -- No iniciar automáticamente
        device_name = nil,  -- Detectar automáticamente
        
        -- Opciones de comportamiento
        chord_mode = true,  -- Permitir acordes
        spacing = true,  -- Añadir espacios alrededor de notas
        
        -- Mapeos
        mappings = {
          start = "<leader>lms",  -- Iniciar entrada MIDI
          stop = "<leader>lme",  -- Detener entrada MIDI
          toggle = "<leader>lmt",  -- Toggle entrada MIDI
        },
      })

      -- Auto-comando para mostrar ayuda al iniciar MIDI input
      vim.api.nvim_create_autocmd("User", {
        pattern = "MidiInputStarted",
        callback = function()
          vim.notify("Entrada MIDI activada - Toca notas en tu teclado MIDI", vim.log.levels.INFO)
        end,
      })
    end,
  },
}

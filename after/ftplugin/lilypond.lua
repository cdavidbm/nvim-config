-- ============================================================================
-- PARCHE LOCAL para nvim-lilypond-suite
-- Corrige el problema de generación de PDF usando --pdf en lugar de -f pdf
-- ============================================================================

local Utils = require('nvls.utils')
local Job = require('nvls.job')
local opts = require('nvls').get_nvls_options().lilypond

-- Sobrescribir el comando LilyCmp con la versión corregida
vim.api.nvim_create_user_command('LilyCmp', function()
  vim.fn.execute('write')
  
  -- Obtener archivo actual directamente
  local current_file = vim.fn.expand('%:p')
  local file_folder = vim.fn.fnamemodify(current_file, ':h')
  local file_name = vim.fn.fnamemodify(current_file, ':t:r')
  
  local args = {
    "-o", vim.fs.joinpath(file_folder, file_name),
    current_file  -- Usar siempre el archivo actual
  }

  -- Agregar flag de formato correcto basado en output
  local output_format = opts.options.output or "pdf"
  if output_format == "pdf" then
    table.insert(args, 1, "--pdf")  -- ✅ Usar --pdf en lugar de -f pdf
  elseif output_format == "svg" then
    table.insert(args, 1, "--svg")
  elseif output_format == "png" then
    table.insert(args, 1, "--png")
  end

  -- Agregar directorios de inclusión
  local include_args = Utils.format_include_dirs(opts.options.include_dir)
  for _, arg in ipairs(include_args) do
    table.insert(args, 1, "-I")
    table.insert(args, 2, arg)
  end

  -- Backend comentado porque causa error en esta instalación de LilyPond
  -- if opts.options.backend then
  --   table.insert(args, 1, "-dbackend=" .. opts.options.backend)
  -- end

  Job:add('lilypond', args)
end, {})

-- Sobrescribir el comando Viewer para abrir el PDF del archivo actual
vim.api.nvim_create_user_command('Viewer', function()
  local current_file = vim.fn.expand('%:p')
  local pdf_file = vim.fn.fnamemodify(current_file, ':r') .. '.pdf'
  local pdf_name = vim.fn.fnamemodify(pdf_file, ':t')
  
  -- Esperar un poco si acaba de compilar
  vim.defer_fn(function()
    require('nvls.viewer').open(pdf_file, pdf_name)
  end, 100)
end, {})

-- Crear comando mejorado con feedback visual
vim.api.nvim_create_user_command('LilyCompile', function()
  vim.cmd('write')
  local current_file = vim.fn.expand('%:p')
  local file_folder = vim.fn.fnamemodify(current_file, ':h')
  local file_name = vim.fn.fnamemodify(current_file, ':t:r')
  
  vim.notify("🎵 Compilando " .. file_name .. ".ly...", vim.log.levels.INFO)
  
  local cmd = string.format('cd %s && lilypond --pdf -o %s %s', 
    vim.fn.shellescape(file_folder),
    vim.fn.shellescape(file_name),
    vim.fn.shellescape(current_file))
  
  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("✅ Compilación exitosa! PDF generado: " .. file_name .. ".pdf", vim.log.levels.INFO)
        -- Auto-abrir PDF si existe
        local pdf_file = file_folder .. '/' .. file_name .. '.pdf'
        if vim.fn.filereadable(pdf_file) == 1 then
          vim.defer_fn(function()
            vim.fn.jobstart('xdg-open ' .. vim.fn.shellescape(pdf_file))
          end, 500)
        end
      else
        vim.notify("❌ Error en compilación. Código: " .. exit_code, vim.log.levels.ERROR)
      end
    end,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line:match("Enhorabuena") or line:match("successfully") then
            print(line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            print(line)
          end
        end
      end
    end,
  })
end, {})

-- Mapear comando alternativo
vim.keymap.set("n", "<leader>lC", "<cmd>LilyCompile<cr>", { 
  desc = "Compilar LilyPond (alternativo con feedback)",
  buffer = true 
})

-- Notificar que el parche está activo
vim.notify("LilyPond: Parche de compilación PDF cargado ✅", vim.log.levels.INFO)

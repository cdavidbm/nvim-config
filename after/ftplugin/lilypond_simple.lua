-- Comandos súper simples que funcionan garantizado

-- Compilar con feedback
vim.keymap.set("n", "<leader>lcc", function()
  vim.cmd("write")
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  local name = vim.fn.expand("%:t:r")
  
  print("🎵 Compilando...")
  local result = vim.fn.system(string.format("cd %s && lilypond --pdf %s", 
    vim.fn.shellescape(dir), 
    vim.fn.shellescape(file)))
  
  if vim.v.shell_error == 0 then
    print("✅ PDF generado: " .. name .. ".pdf")
  else
    print("❌ Error en compilación")
    print(result)
  end
end, { desc = "Compilar LilyPond (simple)", buffer = true })

-- Abrir PDF
vim.keymap.set("n", "<leader>loo", function()
  local pdf = vim.fn.expand("%:r") .. ".pdf"
  if vim.fn.filereadable(pdf) == 1 then
    vim.fn.system("xdg-open " .. vim.fn.shellescape(pdf))
    print("📄 Abriendo PDF...")
  else
    print("❌ PDF no encontrado: " .. pdf)
  end
end, { desc = "Abrir PDF (simple)", buffer = true })

-- Reproducir MIDI
vim.keymap.set("n", "<leader>lpp", function()
  local midi = vim.fn.expand("%:r") .. ".midi"
  if vim.fn.filereadable(midi) == 1 then
    print("🎵 Reproduciendo MIDI...")
    vim.fn.jobstart("play-midi " .. vim.fn.shellescape(midi), {
      on_exit = function(_, code)
        if code == 0 then
          print("✅ Reproducción completada")
        else
          print("❌ Error en reproducción (código " .. code .. ")")
        end
      end
    })
  else
    print("❌ MIDI no encontrado: " .. midi)
    print("💡 Compila primero con <leader>lcc")
  end
end, { desc = "Reproducir MIDI (simple)", buffer = true })

print("✅ Comandos simples cargados: <leader>lcc (compilar) <leader>loo (abrir PDF) <leader>lpp (reproducir MIDI)")

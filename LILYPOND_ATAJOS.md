# Atajos de Teclado para LilyPond en Neovim

## Plugins Instalados

1. **nvim-lilypond-suite** - Suite completa de herramientas para LilyPond
2. **midi-input.nvim** - Entrada de notas usando teclado MIDI
3. **nvim-treesitter** - Resaltado de sintaxis avanzado

---

## Atajos de Teclado (Keymaps)

### Compilación y Visualización

| Atajo | Comando | Descripción |
|-------|---------|-------------|
| `<leader>lc` | `:LilypondCompile` | Compilar archivo LilyPond actual |
| `<leader>lo` | `:LilypondOpenPDF` | Abrir PDF generado |
| `<leader>ls` | `:LilypondSwitchBuffers` | Cambiar entre archivos .ly y .pdf |
| `<leader>lv` | `:LilypondInsertVersion` | Insertar versión de LilyPond |

### Reproductor MIDI/MP3

| Atajo | Comando | Descripción |
|-------|---------|-------------|
| `<leader>lp` | `:LilypondPlayer` | Abrir reproductor de audio |
| `q` | (en player) | Cerrar reproductor |
| `p` | (en player) | Play/Pause |
| `<Alt-l>` | (en player) | Toggle loop |
| `h` | (en player) | Retroceder |
| `l` | (en player) | Avanzar |
| `<Shift-h>` | (en player) | Retroceder (pequeño) |
| `<Shift-l>` | (en player) | Avanzar (pequeño) |
| `j` | (en player) | Disminuir velocidad |
| `k` | (en player) | Aumentar velocidad |
| `<Shift-j>` | (en player) | Velocidad a la mitad |
| `<Shift-k>` | (en player) | Velocidad al doble |

### Silabeo (Hyphenation)

| Atajo | Comando | Descripción |
|-------|---------|-------------|
| `<leader>lh` | `:LilypondHyphenation` | Aplicar silabeo a la palabra bajo el cursor |
| `<leader>lm` | `:LilypondChangeLanguage` | Cambiar idioma de silabeo |

### Entrada MIDI

| Atajo | Comando | Descripción |
|-------|---------|-------------|
| `<leader>lms` | `:MidiInputStart` | Iniciar entrada MIDI |
| `<leader>lme` | `:MidiInputStop` | Detener entrada MIDI |
| `<leader>lmt` | `:MidiInputToggle` | Toggle entrada MIDI |

---

## Comandos Disponibles

### Compilación

- `:LilypondCompile` - Compila el archivo actual
- `:LilypondCompileMain` - Compila el archivo principal (multi-archivo)
- `:LilypondOpenPDF` - Abre el PDF generado
- `:LilypondSwitchBuffers` - Alterna entre .ly y .pdf

### Reproductor

- `:LilypondPlayer` - Abre el reproductor flotante MIDI/MP3
- `:LilypondQuickPlayer` - Compila y reproduce solo la selección visual

### Utilidades

- `:LilypondInsertVersion` - Inserta `\version "2.24.x"`
- `:LilypondHyphenation` - Aplica silabeo a letras
- `:LilypondChangeLanguage` - Cambia idioma de silabeo (es, en, fr, de, etc.)

### MIDI Input

- `:MidiInputStart` - Inicia captura de teclado MIDI
- `:MidiInputStop` - Detiene captura MIDI
- `:MidiInputToggle` - Alterna entrada MIDI
- `:MidiInputDevices` - Lista dispositivos MIDI disponibles

---

## Características Principales

### 1. Compilación Asíncrona
- Compila en background sin congelar Neovim
- Resultados en quickfix list
- Diagnósticos integrados

### 2. Reproductor Integrado
- Reproduce MIDI y MP3
- Ventana flotante
- Controles de velocidad y loop

### 3. QuickPlayer
- Selecciona fragmento de código en modo visual
- `<leader>lp` compila y reproduce solo esa sección
- Útil para probar pequeños fragmentos

### 4. Función de Silabeo
- Coloca automáticamente guiones en letras
- Soporta múltiples idiomas
- Cursor sobre palabra → `<leader>lh`

### 5. Proyectos Multi-archivo
- Define archivo principal
- Compila proyecto completo desde cualquier archivo
- Útil para obras grandes

### 6. Entrada MIDI
- Conecta tu teclado MIDI
- Toca notas → se insertan automáticamente
- Soporte para acordes
- Respeta modos de Vim (insert/replace)

---

## Configuración Personalizada

### Cambiar Formato de Salida

Edita `~/.config/nvim/lua/plugins/lilypond.lua`:

```lua
lilypond = {
  options = {
    output = "svg",  -- Cambiar a svg, png, etc.
  },
}
```

### Configurar Archivo Principal (Multi-archivo)

```lua
lilypond = {
  options = {
    main_file = "main.ly",  -- Tu archivo principal
  },
}
```

### Personalizar Atajos

```lua
lilypond = {
  mappings = {
    compile = "<F5>",  -- Compilar con F5
    open_pdf = "<F6>",  -- Abrir PDF con F6
  },
}
```

---

## Integración con SuperCollider

Si usas SuperCollider (ya tienes scnvim instalado), puedes:

1. Generar música en SuperCollider
2. Exportar a LilyPond usando Fosc o AbjadScore.sc
3. Abrir archivo .ly en Neovim
4. Compilar y editar notación

Ver: `~/scd_y_ly.md` para integración completa.

---

## Tree-sitter Features

Con el parser de LilyPond instalado:

- **Resaltado semántico** - Mejor que regex
- **Text objects** - Navegar por estructuras musicales
- **Selección incremental** - `<C-space>` para expandir selección
- **Indentación inteligente** - Basada en AST

---

## Troubleshooting

### No se encuentra LilyPond

Si aparece error "lilypond not found":

```bash
which lilypond
# Luego en nvim/lua/plugins/lilypond.lua:
# Configurar ruta explícita si es necesario
```

### MIDI Input no funciona

```bash
# Listar dispositivos MIDI
aconnect -l

# Verificar permisos
groups  # Debe incluir 'audio'
```

### PDF no abre automáticamente

```bash
# Instalar visor de PDF
sudo apt-get install evince  # o xdg-utils
```

---

## Recursos Adicionales

- **Wiki nvim-lilypond-suite**: https://github.com/martineausimon/nvim-lilypond-suite/wiki
- **Documentación LilyPond**: https://lilypond.org/doc/v2.24/
- **Tree-sitter LilyPond**: https://github.com/nwhetsell/tree-sitter-lilypond
- **MIDI Input docs**: https://github.com/niveK77pur/midi-input.nvim

---

## Ejemplo de Workflow

1. Abrir archivo: `nvim tormenta.ly`
2. Escribir notación
3. Compilar: `<leader>lc`
4. Ver PDF: `<leader>lo`
5. Reproducir: `<leader>lp`
6. Ajustar código
7. Recompilar: `<leader>lc`

---

*Configuración creada: Diciembre 2025*

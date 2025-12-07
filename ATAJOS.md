# 🎹 Guía de Atajos de Teclado - Neovim

Esta guía lista todos los atajos de teclado de tu configuración de Neovim, organizados por utilidad y categoría.

**Configuración:** Codeium (autocompletado inline) + Avante (chat con Claude)

---

## 📋 Índice

1. [Which-Key - Ayuda de Atajos](#which-key)
2. [Telescope - Búsqueda Fuzzy](#telescope)
3. [Codeium - Autocompletado IA](#codeium)
4. [Avante - Chat con Claude](#avante)
5. [Comment - Comentar Código](#comment)
6. [ToggleTerm - Terminal Integrada](#toggleterm)
7. [GitSigns - Control de Git](#gitsigns)
8. [Surround - Manipular Delimitadores](#surround)
9. [NvimTree - Explorador de Archivos](#nvimtree)
10. [LSP - Language Server](#lsp)
11. [Autocompletado (nvim-cmp)](#autocompletado)
12. [Otros Atajos](#otros)

---

## <a name="which-key"></a>🔑 Which-Key - Ayuda de Atajos

**¿Qué hace?** Muestra automáticamente sugerencias de atajos disponibles.

| Atajo | Descripción |
|-------|-------------|
| `<leader>` + esperar | Muestra todos los atajos disponibles |

**Nota:** `<leader>` es la tecla **Espacio** por defecto

**Grupos disponibles:**
- `<leader>f` → Búsqueda (Telescope)
- `<leader>g` → Git
- `<leader>h` → Git Hunks
- `<leader>t` → Toggle / Terminal
- `<leader>c` → Codeium
- `<leader>a` → Avante (Claude)
- `<leader>w` → Workspace
- `<leader>u` → UV (Python)

---

## <a name="telescope"></a>🔭 Telescope - Búsqueda Fuzzy

### Búsqueda de Archivos

| Atajo | Descripción |
|-------|-------------|
| `<leader>ff` | Buscar archivos |
| `<leader>fa` | Buscar TODOS los archivos (incluye ocultos) |
| `<leader>fr` | Archivos recientes |
| `<leader>fb` | Buscar entre buffers abiertos |

### Búsqueda de Texto

| Atajo | Descripción |
|-------|-------------|
| `<leader>fg` | Buscar texto en todo el proyecto (live grep) |
| `<leader>fw` | Buscar palabra bajo el cursor |
| `<leader>/` | Buscar en el archivo actual |

### Utilidades

| Atajo | Descripción |
|-------|-------------|
| `<leader>fh` | Buscar en la ayuda de Neovim |
| `<leader>fc` | Buscar comandos |
| `<leader>fk` | Ver todos los keymaps |
| `<leader>ft` | Cambiar tema de colores |

### Git

| Atajo | Descripción |
|-------|-------------|
| `<leader>gc` | Ver commits de Git |
| `<leader>gs` | Ver Git status |
| `<leader>gb` | Ver Git branches |

---

## <a name="codeium"></a>🤖 Codeium - Autocompletado IA

**¿Qué hace?** Sugerencias de código automáticas con IA mientras escribes.

### Aceptar Sugerencias

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+g` | Aceptar sugerencia completa |
| `Ctrl+→` | Aceptar siguiente palabra |
| `Ctrl+l` | Aceptar siguiente línea |

### Navegar Sugerencias

| Atajo | Descripción |
|-------|-------------|
| `Alt+]` | Siguiente sugerencia |
| `Alt+[` | Sugerencia anterior |
| `Ctrl+x` | Cancelar/limpiar sugerencia |

### Comandos (Modo Normal)

| Atajo | Descripción |
|-------|-------------|
| `<leader>ce` | Habilitar Codeium |
| `<leader>cd` | Deshabilitar Codeium |
| `<leader>cc` | Abrir chat de Codeium en navegador |

---

## <a name="avante"></a>💬 Avante - Chat con Claude

**¿Qué hace?** Chat interactivo con Claude Code para ayuda con código.

| Atajo | Descripción |
|-------|-------------|
| `:AvanteAsk` | Hacer pregunta a Claude |
| `:AvanteEdit` | Editar código con Claude |
| `:AvanteToggle` | Toggle panel de Avante |

**Uso:** Abre el panel de Avante y chatea con Claude para obtener ayuda, explicaciones o ediciones de código.

---

## <a name="comment"></a>💬 Comment - Comentar Código

### Modo Normal

| Atajo | Descripción |
|-------|-------------|
| `gcc` | Comentar/descomentar línea actual |
| `gc` + movimiento | Comentar líneas (ej: `gc3j`) |
| `gbc` | Comentar bloque |
| `gcO` | Agregar comentario arriba |
| `gco` | Agregar comentario abajo |
| `gcA` | Agregar comentario al final de línea |

### Modo Visual

| Atajo | Descripción |
|-------|-------------|
| `gc` | Comentar selección |
| `gb` | Comentar bloque |

---

## <a name="toggleterm"></a>💻 ToggleTerm - Terminal Integrada

### Abrir Terminal

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+\` | Toggle terminal flotante |
| `<leader>tf` | Terminal flotante |
| `<leader>th` | Terminal horizontal |
| `<leader>tv` | Terminal vertical |

### Dentro del Terminal

| Atajo | Descripción |
|-------|-------------|
| `Esc` | Salir a modo normal |
| `Ctrl+h/j/k/l` | Navegar entre ventanas |

---

## <a name="gitsigns"></a>🔀 GitSigns - Control de Git

### Navegación

| Atajo | Descripción |
|-------|-------------|
| `]c` | Siguiente hunk (cambio) |
| `[c` | Hunk anterior |

### Acciones con Hunks

| Atajo | Descripción |
|-------|-------------|
| `<leader>hp` | Preview del hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage todo el buffer |
| `<leader>hR` | Reset todo el buffer |
| `<leader>hu` | Undo stage hunk |

### Git Blame y Diff

| Atajo | Descripción |
|-------|-------------|
| `<leader>hb` | Ver blame de la línea |
| `<leader>tb` | Toggle blame inline |
| `<leader>hd` | Diff del archivo actual |

---

## <a name="surround"></a>🎯 Surround - Manipular Delimitadores

### Agregar

| Atajo | Descripción |
|-------|-------------|
| `ysiw"` | Rodear palabra con comillas dobles |
| `ysiw'` | Rodear palabra con comillas simples |
| `ysiw)` | Rodear palabra con paréntesis |
| `yss"` | Rodear línea completa |

### Eliminar

| Atajo | Descripción |
|-------|-------------|
| `ds"` | Eliminar comillas dobles |
| `ds'` | Eliminar comillas simples |
| `ds)` | Eliminar paréntesis |

### Cambiar

| Atajo | Descripción |
|-------|-------------|
| `cs"'` | Cambiar comillas dobles por simples |
| `cs)]` | Cambiar paréntesis por corchetes |

### Modo Visual

| Atajo | Descripción |
|-------|-------------|
| `S"` | Rodear selección con comillas |

---

## <a name="nvimtree"></a>🌳 NvimTree - Explorador de Archivos

### Abrir/Cerrar

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+n` | Toggle árbol de archivos |
| `<leader>e` | Foco en árbol de archivos |

### Dentro de NvimTree

| Atajo | Descripción |
|-------|-------------|
| `Enter` | Abrir archivo o carpeta |
| `a` | Crear nuevo archivo/carpeta |
| `d` | Eliminar |
| `r` | Renombrar |
| `c` | Copiar |
| `p` | Pegar |
| `R` | Refrescar árbol |
| `H` | Toggle archivos ocultos |
| `q` | Cerrar árbol |

---

## <a name="lsp"></a>🔧 LSP - Language Server

### Navegación de Código

| Atajo | Descripción |
|-------|-------------|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gi` | Ir a implementación |
| `gr` | Ver referencias |
| `K` | Ver documentación (hover) |

### Refactoring

| Atajo | Descripción |
|-------|-------------|
| `<leader>rn` | Renombrar símbolo |
| `<leader>ca` | Code action |
| `<leader>f` | Formatear código |

---

## <a name="autocompletado"></a>✨ Autocompletado (nvim-cmp)

### En el Menú de Completado

| Atajo | Descripción |
|-------|-------------|
| `Tab` | Siguiente sugerencia |
| `Shift+Tab` | Sugerencia anterior |
| `Enter` | Confirmar selección |
| `Ctrl+Space` | Activar completado manualmente |
| `Ctrl+e` | Cancelar completado |

---

## <a name="otros"></a>⚙️ Otros Atajos

### Navegación Tmux

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+h` | Ir a ventana/panel izquierda |
| `Ctrl+j` | Ir a ventana/panel abajo |
| `Ctrl+k` | Ir a ventana/panel arriba |
| `Ctrl+l` | Ir a ventana/panel derecha |

### Colorizer

| Atajo | Descripción |
|-------|-------------|
| `<leader>tc` | Toggle colorizer |

### Emmet (HTML/CSS)

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+y,` | Expandir abreviatura Emmet |

---

## 💡 Tips Rápidos

1. **Buscar y editar:** `<leader>fg` → buscar texto → `Enter`
2. **Git workflow:** `]c` → `<leader>hp` → `<leader>hs`
3. **Comentar bloques:** `vip` → `gc`
4. **Terminal rápido:** `Ctrl+\`
5. **Ayuda visual:** Presiona `<leader>` y espera para ver opciones

---

**Configuración:** Virtual Adept Neovim Setup  
**Autocompletado IA:** Codeium  
**Chat IA:** Avante (Claude Code)

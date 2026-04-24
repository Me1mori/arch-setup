# 🎨 Guía de Configuración Post-Instalación

Aquí encontrarás tips y guías para personalizar tu entorno Hyprland + Noctalia.

## 📍 Carpetas importantes

```
~/.config/noctalia/          # Configuración de Noctalia
~/.config/hypr/              # Configuración de Hyprland (si quieres override)
~/.local/share/noctalia/     # Datos y caché de Noctalia
~/.cache/noctalia/           # Cache de Noctalia
```

## 🎹 Keybinds principales en Hyprland

| Combinación | Acción |
|-------------|--------|
| `Super + Return` | Abrir terminal |
| `Super + D` | Launcher/Menú de aplicaciones |
| `Super + Q` | Cerrar ventana |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Super + Mouse (drag)` | Mover ventana flotante |
| `Alt + Tab` | Cambiar ventanas |

## 🎨 Personalizar Noctalia

### Cambiar tema de color

Noctalia viene con temas predefinidos. Para cambiar:

```bash
# Ver temas disponibles
ls ~/.config/noctalia/themes/

# Editar la configuración principal
nano ~/.config/noctalia/config.qml
```

### Wallpaper

```bash
# Establecer wallpaper personalizado
# Coloca tu imagen en una carpeta y configúrala en Noctalia
# O usa el menú de configuración integrado
```

## 🔧 Configurar VSCode

### Extensiones recomendadas

```bash
# Instalar desde terminal
code --install-extension ms-vscode.cpptools
code --install-extension rust-lang.rust-analyzer
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
```

### Tema oscuro con Noctalia

VSCode detectará automáticamente el tema. Si no, configúralo manualmente:

1. Abre VSCode
2. `Ctrl + K + T` para seleccionar tema
3. Busca y selecciona tu tema preferido

## 🌙 Luz nocturna (wlsunset)

Si instalaste `wlsunset`, puedes activar la luz nocturna:

```bash
# Activar luz nocturna
wlsunset -l 32.51 -L 117.02 &

# Detener
pkill wlsunset
```

(Ajusta los valores de latitud `-l` y longitud `-L` a tu ubicación)

Para Tijuana: `-l 32.51 -L 117.02`

## 🖨️ Fuentes recomendadas

```bash
# Instalar fuentes monoespaciadas modernas
yay -S ttf-fira-code ttf-firacode noto-fonts noto-fonts-emoji

# Actualizar caché de fuentes
fc-cache -fv
```

### Fuentes recomendadas por app:

- **Terminal (Kitty):** Fira Code, JetBrains Mono
- **VSCode:** Fira Code, Cascadia Code
- **UI (Noctalia):** Noto Sans

Edita `~/.config/kitty/kitty.conf`:

```ini
font_family Fira Code
font_size 12
```

## 📱 Configurar Kitty

Edita `~/.config/kitty/kitty.conf`:

```ini
# Tamaño de ventana por defecto
remember_window_size  yes
initial_window_width  120c
initial_window_height 30c

# Fuente
font_family Fira Code
font_size 12

# Tema oscuro (adapta a tu preferencia)
foreground #c3c1c1
background #0a0a0a

# Opacidad
background_opacity 0.95
```

## 🌐 Firefox con tema oscuro

1. Abre Firefox
2. `about:preferences` → Inicio → Tema
3. Selecciona **Oscuro**
4. Opcional: Instala extensión "Dark Reader" para más control

## 🎮 Alias útiles

Añade a `~/.bashrc` o `~/.zshrc`:

```bash
# Actualizar sistema
alias sysupdate='sudo pacman -Syu && yay -Su'

# Limpiar cache
alias clearcache='yay -Sc && sudo pacman -Sc'

# Ver temperatura de CPU
alias temp='watch -n 1 "sensors"'

# Monitorear recursos
alias monitor='watch -n 1 "free -h && ps aux | head -n 11"'

# Rápido acceso a configuración
alias config-noctalia='nano ~/.config/noctalia/config.qml'
alias config-kitty='nano ~/.config/kitty/kitty.conf'
```

Después recarga:
```bash
source ~/.bashrc
```

## 🔌 Configurar múltiples monitores

Si tienes múltiples monitores, edita `~/.config/hypr/hyprland.conf`:

```conf
monitor=HDMI-1,1920x1080@60,0x0,1
monitor=DP-1,2560x1440@144,1920x0,1
```

Usa `hyprctl monitors` para ver tus monitores.

## 🎵 Audio y volumen

Noctalia incluye controles de volumen. Para configurar:

```bash
# Ver dispositivos de audio
pactl list short sinks

# Cambiar volumen vía CLI
pactl set-sink-volume 0 +5%
pactl set-sink-volume 0 -5%
pactl set-sink-mute 0 toggle
```

## 💾 Backup de configuración

```bash
# Crear backup
tar -czf ~/noctalia-config-backup.tar.gz ~/.config/noctalia/

# Restaurar
tar -xzf ~/noctalia-config-backup.tar.gz -C ~
```

## 🐛 Debugging y logs

```bash
# Ver logs de Noctalia
journalctl -u noctalia -n 50 -f

# Logs de Hyprland
cat ~/.cache/hy*/hyprland.log

# Verificar estado del sistema
systemctl status

# Monitorear recursos en tiempo real
htop
```

## 🆘 Problemas comunes

### **La pantalla se ve pixelada/borrosa**

Verifica tu escala de DPI:
```bash
# En ~/.config/noctalia/
# Busca la propiedad dpi y ajusta a 96 (defecto) o tu valor
```

### **Las ventanas flotantes no responden**

Cierra y reabre Hyprland:
```bash
# Presiona Super + Q para cerrar ventanas
# O reinicia Hyprland con: Super + M (según tu config)
```

### **Noctalia usa mucha CPU**

```bash
# Verifica qué procesos consumen recursos
top
# Presiona Shift + M para ordenar por memoria
```

### **Problemas con XWayland**

Algunos programas viejos necesitan XWayland. Si hay problemas:

```bash
yay -S xwayland
```

## 📚 Recursos útiles

- [Documentación Noctalia](https://docs.noctalia.dev)
- [Wiki Hyprland](https://wiki.hyprland.org)
- [Arch Wiki](https://wiki.archlinux.org)
- [Discord Noctalia](https://discord.noctalia.dev)

---

**¡Disfruta tu nuevo entorno de escritorio! 🚀**

# Setup Arch Linux - Hyprland + Noctalia Shell

Script de instalación automático para configurar un entorno de escritorio completo en Arch Linux con Hyprland, Noctalia Shell, Firefox, VSCode y Kitty.

## 📋 Requisitos

- **Arch Linux instalado** (usando `archinstall` o manual)
- **Usuario creado** (debe ser diferente a root)
- **Conexión a internet** estable
- **Permisos sudo** configurados

## 🚀 Instalación

### Paso 1: Instalar Arch Linux base (sin entorno gráfico)

```bash
# Usar archinstall sin seleccionar perfil de escritorio
# Solo instalar: base, linux, linux-firmware
# Crear usuario: me1mori (o el que prefieras)
# NO seleccionar ningún desktop environment
```

### Paso 2: Reiniciar y clonar el repositorio

```bash
# Después de reiniciar con Arch instalado
sudo pacman -S git
git clone <URL-DEL-REPOSITORIO> ~/arch-setup
cd ~/arch-setup
```

### Paso 3: Ejecutar el script

```bash
# Dar permisos de ejecución
chmod +x setup-arch.sh

# Ejecutar con sudo
sudo ./setup-arch.sh
```

El script pedirá tu contraseña de usuario en algún punto (necesaria para compilar paquetes de AUR). El resto se ejecutará automáticamente mostrando el progreso.

## 📦 ¿Qué se instala?

| Paquete | Propósito | Estado |
|---------|-----------|--------|
| **Hyprland** | Compositor Wayland moderno | ✓ Instalado |
| **Noctalia Shell** | Desktop Shell minimalista | ✓ Instalado |
| **Firefox** | Navegador web | ✓ Instalado |
| **VSCode** | Editor de código | ✓ Instalado |
| **Kitty** | Terminal moderna | ✓ Instalado |
| **yay** | AUR Helper | ✓ Instalado |

### Dependencias opcionales también instaladas:

- `cliphist` - Historial del portapapeles
- `wlsunset` - Luz nocturna
- `polkit-gnome` - Gestor de permisos
- `xdg-desktop-portal-hyprland` - Portal de escritorio para Hyprland
- `dunst` - Demonio de notificaciones
- `waybar` - Barra de estado

## ⚙️ Después de la instalación

### 1. **Primera vez que reinicies**
   - En la pantalla de login (SDDM), selecciona **Hyprland** en el menú de sesiones
   - Inicia sesión con tu usuario

### 2. **Configurar Noctalia**
   - Noctalia debería iniciar automáticamente
   - Si quieres personalizarlo, edita `~/.config/noctalia/`

### 3. **Abrir aplicaciones**
   - **Terminal:** `Super + T` (o abre Kitty manualmente)
   - **Firefox:** Click en el ícono o usa `Super + B`
   - **VSCode:** Click en el ícono o usa el launcher

## 🔧 Solución de problemas

### **"Command not found: yay"**
El script instala yay automáticamente. Si aún así falla:
```bash
sudo pacman -S --noconfirm base-devel
cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
```

### **Noctalia no inicia**
Asegúrate de que Hyprland esté seleccionado como sesión. Abre una terminal y ejecuta:
```bash
noctalia
```

### **No puedo compilar paquetes de AUR**
El script necesita permisos sudo sin contraseña para el usuario. Configúralo con:
```bash
sudo visudo
# Añade al final:
# tu_usuario ALL=(ALL) NOPASSWD: ALL
```

### **El script falla a mitad**
Puedes ejecutarlo de nuevo sin problemas. Es idempotente y reanudará desde donde se quedó.

## 📚 Documentación

- **Noctalia Docs:** https://docs.noctalia.dev
- **Hyprland Docs:** https://wiki.hyprland.org
- **Arch Wiki:** https://wiki.archlinux.org

## 💬 Soporte

Si encuentras problemas:

1. **Discord Noctalia:** https://discord.noctalia.dev
2. **GitHub Issues:** Abre un issue en este repositorio
3. **Arch Wiki:** Consulta el wiki de Arch Linux

## 📝 Notas importantes

- **El script requiere sudo** para instalar paquetes de sistema
- **Pide permisos solo cuando es necesario** (compilación de AUR)
- **Reinicia automáticamente** al final de la instalación
- Puedes pausar antes del reboot para verificar que todo esté correcto

## 🔄 Actualizar después

```bash
# Actualizar el sistema
sudo pacman -Syu

# Actualizar paquetes de AUR
yay -Syu

# Actualizar Noctalia específicamente
yay -S noctalia-shell
```

## ⚡ Comandos rápidos útiles

```bash
# Recargar configuración de Noctalia
noctalia-shell --reload

# Ver logs de Noctalia
journalctl -u noctalia -f

# Actualizar yay
yay -Syu

# Buscar paquetes en AUR
yay -Ss nombre_paquete
```

---

**Creado para Arch Linux + Hyprland + Noctalia Shell** 🚀

#!/bin/bash

# ============================================================================
# Setup Arch Linux - Hyprland + Noctalia Shell + Firefox + VSCode + Kitty
# ============================================================================
# Este script instala un entorno completo de escritorio basado en Wayland
# Uso: ./setup-arch.sh
# ============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variables
TOTAL_STEPS=6
CURRENT_STEP=0
USER="${SUDO_USER:-$(whoami)}"
HOME_DIR="/home/$USER"

# ============================================================================
# Funciones
# ============================================================================

print_header() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}   Setup Arch Linux - Hyprland + Noctalia Shell ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    local percentage=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    echo -e "${BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}]${NC} ${GREEN}$1${NC}"
    echo -e "${YELLOW}Progreso: ${percentage}%${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
    echo ""
}

print_error() {
    echo -e "${RED}✗ Error: $1${NC}"
    echo ""
    exit 1
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

progress_bar() {
    local duration=$1
    local interval=0.1
    local steps=$(echo "$duration / $interval" | bc)
    
    for ((i = 0; i < steps; i++)); do
        local percentage=$((i * 100 / steps))
        printf "\r${YELLOW}Progreso: ${percentage}%%${NC} ["
        printf "%${percentage}s" | tr ' ' '='
        printf "%$((100 - percentage))s" | tr ' ' '-'
        printf "]"
        sleep $interval
    done
    printf "\r${GREEN}✓ Completado${NC} [==================================================]\n"
    echo ""
}

# ============================================================================
# Verificaciones iniciales
# ============================================================================

print_header

if [[ $EUID -ne 0 ]]; then
    print_error "Este script debe ejecutarse con sudo"
fi

if ! command -v pacman &> /dev/null; then
    print_error "Este script es solo para Arch Linux"
fi

print_info "Verificando conexión a internet..."
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    print_error "No hay conexión a internet"
fi
print_success "Conexión a internet OK"

print_info "Usuario: $USER"
print_info "Directorio home: $HOME_DIR"
echo ""

# ============================================================================
# PASO 1: Actualizar el sistema
# ============================================================================

print_step "Actualizando el sistema"

pacman -Syu --noconfirm > /dev/null 2>&1 || print_error "Error al actualizar el sistema"

print_success "Sistema actualizado"

# ============================================================================
# PASO 2: Instalar dependencias de compilación y herramientas base
# ============================================================================

print_step "Instalando dependencias de compilación"

pacman -S --noconfirm base-devel git > /dev/null 2>&1 || print_error "Error al instalar dependencias"

print_success "Dependencias instaladas"

# ============================================================================
# PASO 3: Instalar yay (AUR helper)
# ============================================================================

print_step "Instalando yay (AUR helper)"

if ! command -v yay &> /dev/null; then
    print_info "yay no está instalado, compilando desde AUR..."
    
    cd /tmp
    rm -rf yay 2>/dev/null || true
    git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1
    cd yay
    
    # Cambiar permisos para que el usuario pueda compilar
    chown -R $USER:$USER /tmp/yay
    
    # Compilar e instalar
    sudo -u $USER makepkg -si --noconfirm > /dev/null 2>&1 || print_error "Error compilando yay"
    
    cd ~
    rm -rf /tmp/yay
else
    print_info "yay ya está instalado"
fi

print_success "yay instalado"

# ============================================================================
# PASO 4: Instalar Hyprland y dependencias
# ============================================================================

print_step "Instalando Hyprland y dependencias"

print_info "Instalando paquetes base..."
sudo -u $USER yay -S --noconfirm hyprland > /dev/null 2>&1 || print_error "Error instalando Hyprland"

print_info "Instalando utilidades recomendadas..."
sudo -u $USER yay -S --noconfirm \
    polkit-gnome \
    xdg-desktop-portal-hyprland \
    dunst \
    waybar > /dev/null 2>&1

print_success "Hyprland instalado"

# ============================================================================
# PASO 5: Instalar Noctalia Shell
# ============================================================================

print_step "Instalando Noctalia Shell"

print_info "Instalando noctalia-shell vía yay..."
sudo -u $USER yay -S --noconfirm noctalia-shell > /dev/null 2>&1 || print_error "Error instalando Noctalia"

print_info "Instalando dependencias opcionales recomendadas..."
sudo -u $USER yay -S --noconfirm \
    cliphist \
    wlsunset \
    python3 > /dev/null 2>&1 || true

print_success "Noctalia Shell instalado"

# ============================================================================
# PASO 6: Instalar aplicaciones (Firefox, VSCode, Kitty)
# ============================================================================

print_step "Instalando aplicaciones (Firefox, VSCode, Kitty)"

print_info "Instalando Firefox..."
sudo -u $USER yay -S --noconfirm firefox > /dev/null 2>&1 || print_error "Error instalando Firefox"

print_info "Instalando Visual Studio Code..."
sudo -u $USER yay -S --noconfirm code > /dev/null 2>&1 || print_error "Error instalando VSCode"

print_info "Instalando Kitty (terminal)..."
sudo -u $USER yay -S --noconfirm kitty > /dev/null 2>&1 || print_error "Error instalando Kitty"

print_success "Aplicaciones instaladas"

# ============================================================================
# Post-instalación
# ============================================================================

print_header

echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}     ${GREEN}✓ ¡Se ha instalado todo correctamente!${NC}              ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${BLUE}Paquetes instalados:${NC}"
echo "  ✓ Hyprland (Compositor Wayland)"
echo "  ✓ Noctalia Shell (Desktop Shell)"
echo "  ✓ Firefox (Navegador)"
echo "  ✓ Visual Studio Code (Editor)"
echo "  ✓ Kitty (Terminal)"
echo "  ✓ yay (AUR Helper)"
echo ""

echo -e "${YELLOW}Próximos pasos:${NC}"
echo "  1. Reinicia el sistema"
echo "  2. En la pantalla de login, selecciona 'Hyprland' como sesión"
echo "  3. Inicia sesión con tu usuario"
echo "  4. Noctalia Shell debería iniciarse automáticamente"
echo ""

echo -e "${BLUE}Información útil:${NC}"
echo "  • Carpeta de configuración: ~/.config/noctalia/"
echo "  • Carpeta de caché: ~/.cache/noctalia/"
echo "  • Documentación: https://docs.noctalia.dev"
echo "  • Discord: https://discord.noctalia.dev"
echo ""

read -p "Presiona ENTER para reiniciar el sistema..."
echo ""

echo -e "${YELLOW}Reiniciando en 5 segundos...${NC}"
sleep 5

reboot

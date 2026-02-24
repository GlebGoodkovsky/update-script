#!/bin/bash

set -e

echo
echo "    █████  █████  █████████ "
echo "   ░░███  ░░███  ███░░░░░███"
echo "    ░███   ░███ ░███    ░░░ "
echo "    ░███   ░███ ░░█████████ "
echo "    ░███   ░███  ░░░░░░░░███"
echo "    ░███   ░███  ███    ░███"
echo "    ░░████████  ░░█████████ "
echo "     ░░░░░░░░    ░░░░░░░░░  "
echo
echo "      Update Script (US)"
echo
echo "Select your system:"
echo "1) Arch based (binaries only)"
echo "2) Arch based (with AUR compiling)"
echo "3) Ubuntu based"
echo "q) Quit"
echo

read -rp "Enter choice: " choice

# Handle quit first
if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
    echo "Exiting."
    exit 0
fi

# Prompt sudo password upfront
sudo true

# Keep sudo alive (prompts when expired)
while true; do
    if ! sudo -n true 2>/dev/null; then
        sudo true
    fi
    sleep 300
    kill -0 "$$" 2>/dev/null || exit
done &

update_arch_binary() {
    echo "[1/2] Updating official repositories (binaries only)..."
    yes | sudo pacman -Syu
    
    echo "[2/2] Removing orphans..."
    orphans=$(pacman -Qtdq)
    [[ -n "$orphans" ]] && yes | sudo pacman -Rns $orphans
}

update_arch_full() {
    echo "[1/3] Full system update via yay..."
    yay -Syu --noconfirm
    
    echo "[2/3] Flatpak..."
    command -v flatpak >/dev/null 2>&1 && flatpak update -y
    
    echo "[3/3] Orphans..."
    orphans=$(pacman -Qtdq)
    [[ -n "$orphans" ]] && yes | sudo pacman -Rns $orphans
}

update_ubuntu() {
    echo "[1/4] Updating package lists and upgrading packages..."
    sudo apt update && yes | sudo apt upgrade -y

    echo "[2/4] Updating Flatpak apps..."
    if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y
    else
        echo "Flatpak not installed — skipping."
    fi

    echo "[3/4] Removing unused packages..."
    sudo apt autoremove -y

    echo "[4/4] Cleaning package cache..."
    sudo apt autoclean -y
}

case "$choice" in
    1) update_arch_binary ;;
    2) update_arch_full ;;
    3) update_ubuntu ;;
    *) echo "Invalid"; exit 1 ;;
esac

echo
echo "✅ System fully updated."
